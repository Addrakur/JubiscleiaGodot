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
	if body.is_in_group(target) && !body.health_component.is_getting_hit:
		body.health_component.update_health(damage)
		body.velocity.y = knockup_force
		if body.position.x > parent.position.x:
			body.velocity.x = knockback_force
		else:
			body.velocity.x = -knockback_force
	elif body.is_in_group("terrain") && destroy_on_terrain:
		parent.queue_free()
	if one_hit_destroy:
		parent.queue_free()
