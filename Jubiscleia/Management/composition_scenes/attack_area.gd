extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

@export_group("Bools")
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false

var damage: float
var knockup_force: float
var knockback_force: float

func on_body_entered(body):
	if body.is_in_group(target) and not body.health_component.invulnerable:
		body.health_component.update_health(damage)
		if body.hit_state != null:
			body.hit_state.knockup_force = knockup_force
			body.hit_state.knockback_force = knockback_force
			body.hit_state.direction = 1 if body.position.x > parent.position.x else -1
	elif body.is_in_group("terrain") and destroy_on_terrain:
		parent.queue_free()
	if one_hit_destroy:
		parent.queue_free()
