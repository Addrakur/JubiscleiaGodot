extends Node2D

@export var max_health: float
@export var animator: AnimationPlayer
@export var destroy_after_dead: bool
@onready var parent: Node2D = get_parent()
var current_health: float = 1
var is_getting_hit: bool = false

func _ready() -> void:
	current_health = max_health

func _process(_delta):
	die()

func update_health(value: float, knockback: bool, knockback_force: float) -> void:
	is_getting_hit = true
	current_health -= value
	if animator != null:
		animator.play("hit")
	if knockback:
		pass

func die() -> void:
	if current_health <= 0:
		parent.alive = false

