extends Node2D

@export var max_health: float
@export var animator: AnimationPlayer
@export var parent: Node2D
@export var destroy_after_dead: bool
var current_health: float = 1
var alive: bool = true
var is_getting_hit: bool = false

func _ready() -> void:
	current_health = max_health

func update_health(value: float) -> void:
	parent.is_attacking = false
	is_getting_hit = true
	current_health -= value
	animator.play("hit")

func die() -> void:
	if current_health <= 0:
		alive = false
		animator.play("dead")
		if destroy_after_dead:
			parent.queue_free()

