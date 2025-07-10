extends CharacterBody2D

enum BallStates {PASSIVE = 0, ACTIVE = 1} 
signal respawn
signal start

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var paddle: CharacterBody2D = $"../Paddle"
@onready var bottom: StaticBody2D = $"../Bottom"
@onready var start_position = Vector2(800,400)
@onready var ball_state = BallStates.PASSIVE
@onready var initial_angle: float = 0
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"

@export var down_vector = Vector2(0,250)


func _ready() -> void:
	var initial: bool = true
	_respawn(initial)


func _physics_process(delta: float) -> void:
	_get_input()
	match ball_state:
		0:
			pass
		1:
			var collision = move_and_collide(velocity * delta)
			if not collision:
				move_and_collide(velocity * delta)
				pass
			elif collision:
				var rid = collision.get_collider_rid()
				if rid == bottom.get_rid():
					var initial: bool = false
					_respawn(initial)
				tile_map_layer.brick_impact(rid)
				velocity = velocity.bounce(collision.get_normal())
				pass


func _respawn(initial: bool) -> void:
	self.position = start_position
	paddle.position.x = 800
	ball_state = BallStates.PASSIVE
	if initial:
		pass
	elif not initial:
		self.emit_signal("respawn")


func _set_launch_angle() -> void:
	initial_angle = deg_to_rad(randf_range(-30,30))
	velocity = Vector2(
	down_vector.x * cos(initial_angle) - down_vector.y * sin(initial_angle),
	down_vector.x * sin(initial_angle) + down_vector.y * cos(initial_angle))


func _get_input() -> void:
	match ball_state:
		1:
			pass
		0:
			if Input.is_action_just_released("Start"):
				self.emit_signal("start")
				_set_launch_angle()
				await canvas_layer.start_timer()
				ball_state = BallStates.ACTIVE
				
