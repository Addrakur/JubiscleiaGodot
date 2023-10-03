extends Node2D

@export var max_health: int
@export var animator: AnimationPlayer
@export var parent: Node2D
@export var destroy_after_dead: bool
var current_health: int = 1
var alive: bool = true

func _ready() -> void:
	current_health = max_health

func update_health(value: float) -> void:
	current_health -= value

func die() -> void:
	if current_health <= 0:
		alive = false
		animator.play("dead")
		if destroy_after_dead:
			parent.queue_free()

