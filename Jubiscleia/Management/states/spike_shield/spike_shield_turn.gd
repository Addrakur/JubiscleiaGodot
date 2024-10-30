class_name SpikeShieldEnemyTurn
extends LimboState

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var attack: String

func _enter() -> void:
	print("enter " + name)
	if parent.turn_attack:
		animation.play("turn_attack")
	else:
		animation.play("turn")
	parent.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "turn":
		dispatch("turn_to_walk")
	elif anim == "turn_attack":
		dispatch("turn_to_idle")

func turn():
	if parent.direction == 1:
		parent.left()
	else:
		parent.right()
	parent.set_direction()

func _exit():
	print("exit " + name)
