extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

@export_group("Floats")
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float
@export_group("Bools")
@export var knockback: bool
@export var knockup: bool = false
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false


func on_body_entered(body):
	if body.is_in_group(target) && !body.health_component.is_getting_hit:
		body.health_component.update_health(damage, knockback, knockback_force)
		if knockup:
			parent.velocity.y = knockup_force
	elif body.is_in_group("terrain") && destroy_on_terrain:
		parent.queue_free()
	if one_hit_destroy:
		parent.queue_free()
