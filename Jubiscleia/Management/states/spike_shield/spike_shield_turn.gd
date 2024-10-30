class_name SpikeShieldEnemyTurn
extends LimboState

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var attack: String

func _enter() -> void:
	set_physics_process(true)
	animation.play("turn")
	parent.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "turn" or anim == "turn_attack":
		dispatch("turn_to_walk")

func turn():
	if parent.direction == 1:
		parent.left()
	else:
		parent.right()
