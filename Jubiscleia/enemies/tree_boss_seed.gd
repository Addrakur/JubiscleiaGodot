extends RigidBody2D

@export var top_size_y: float
@export var bot_size_y: float
@export var left_size_x: float
@export var right_size_x: float

var can_destroy: bool = false

func _physics_process(_delta: float) -> void:
	if can_destroy:
		queue_free()
