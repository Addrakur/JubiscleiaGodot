extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String
@export var damage: float
@export var knockup_force: float
var knockup: bool = false

func on_body_entered(body):
	if body.is_in_group(target):
		body.health_component.update_health(damage)
		if knockup:
			parent.velocity.y = knockup_force
