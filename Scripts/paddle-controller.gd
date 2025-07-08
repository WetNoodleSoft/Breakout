extends CharacterBody2D

@export var speed: float = 20.0
@export var accel: float = 0.0
@export var ramp: float = 15.0

@onready var input_direction: float = 0.0

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	_get_input()
	var target_speed = input_direction * speed
	accel = (target_speed - velocity.x)
	velocity.x += ramp * accel * delta
	move_and_collide(velocity)
	if position.y != 860:
		print(position.y)
	position.y = 860



func _get_input() -> void:
	input_direction = Input.get_axis("Left", "Right")
