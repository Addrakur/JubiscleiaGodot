extends Node2D

@export var speed_x: float
@export var speed_y: float
var direction: float
var can_destroy: bool = false

var horizontal: bool

func _physics_process(delta: float) -> void:
	if horizontal:
		position.x += direction * speed_x * delta
	elif not horizontal:
		position.y += speed_y * delta
	
	if can_destroy:
		queue_free()
