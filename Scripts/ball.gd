extends CharacterBody2D

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var paddle: CharacterBody2D = $"../Paddle"


func _ready() -> void:
	var initial_angle: float = deg_to_rad(randi_range(-45, 45))
	var down_vector = Vector2(0 , 250)
	velocity = Vector2(
		down_vector.x * cos(initial_angle) - down_vector.y * sin(initial_angle),
		down_vector.x * sin(initial_angle) + down_vector.y * cos(initial_angle))


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var rid = collision.get_collider_rid()
		tile_map_layer.brick_impact(rid)
	move_and_collide(velocity * delta)
