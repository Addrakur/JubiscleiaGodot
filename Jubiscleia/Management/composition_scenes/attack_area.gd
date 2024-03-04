extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

@export var damage: float
@export var knockup_force: float
@export var knockback_force: float

@export_group("Bools")
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false

func _ready():
	#print(parent.name + ": " + name + ": " + str(damage))
	pass

func on_body_entered(body):
	if body.is_in_group(target) and not body.health_component.invulnerable:
		body.health_component.update_health(damage)
		if parent.name == "Player":
			if PlayerVariables.my_knockup == true:
				parent.velocity.y = PlayerVariables.spear_jump_my_knockup
		if not body.health_component.knockback_imunity:
			body.hit_state.knockup_force = knockup_force * body.hit_state.knock_multi
			body.hit_state.knockback_force = knockback_force * body.hit_state.knock_multi
			body.hit_state.direction = 1 if body.position.x > parent.position.x else -1
		if body.fsm.state == body.hit_state:
			body.fsm.change_state(body.idle_state)
			body.fsm.change_state(body.hit_state)
	elif body.is_in_group("terrain") and destroy_on_terrain:
		parent.queue_free()
	if one_hit_destroy:
		parent.queue_free()
	
	print(body.name + " foi atacado por " + parent.name)
