extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

@export_group("Bools")
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false

var damage: float
var knockup_force: float
var knockback_force: float
var duration: float

func on_body_entered(body):
	if body.is_in_group(target) and not body.health_component.invulnerable:
		body.health_component.update_health(damage)
		if body.alive:
			#body.velocity = Vector2(knockback_force if body.position.x > parent.position.x else -knockback_force,knockup_force)
			duration = sqrt(pow(knockback_force,2) + pow(knockup_force,2)) / 600
			var hit_tween = get_tree().create_tween().set_parallel(true)
			hit_tween.tween_property(body, "position", Vector2(body.position.x + knockback_force if body.position.x > parent.position.x else body.position.x - knockback_force, body.position.y + knockup_force),duration)
			
	elif body.is_in_group("terrain") and destroy_on_terrain:
		parent.queue_free()
	if one_hit_destroy:
		parent.queue_free()
