class_name SpikeShieldEnemyAttack
extends LimboState

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var attack: String

var move: bool = false

func _enter() -> void:
	parent.is_attacking = true
	parent.velocity.x = 0
	animation.play("attack")
	parent.attack_area.attack_name = parent.name + attack

func _exit() -> void:
	parent.is_attacking = false
	attack_timer.start()

func _on_animation_finished(anim):
	if anim == "attack":
		dispatch("attack_to_idle")
