class_name BigWormAttack
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer

@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	big_worm.attack_area.damage = damage
	big_worm.attack_area.knockback_force = knockback_force
	big_worm.attack_area.knockup_force = knockup_force
	big_worm.is_attacking = true
	big_worm.velocity.x = 0
	if big_worm.player_ref.position.x > big_worm.position.x:
		big_worm.right()
	else:
		big_worm.left()
	animation.play("attack")

func exit_state() -> void:
	set_physics_process(false)
	big_worm.is_attacking = false

func _on_animation_finished(anim):
	if anim == "attack":
		big_worm.attack_timer.start()
		if big_worm.can_attack_player:
			big_worm.fsm.change_state(big_worm.idle_state)
		else:
			big_worm.fsm.change_state(big_worm.move_state)
