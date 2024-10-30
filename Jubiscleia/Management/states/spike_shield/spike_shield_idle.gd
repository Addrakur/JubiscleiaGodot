class_name SpikeShieldEnemyIdle
extends LimboState

@export var parent: SpikeShieldEnemy
@export var idle_timer: Timer
@export var animation: AnimationPlayer

func _enter() -> void:
	idle_timer.start()
	animation.play("idle")
	parent.velocity.x = 0
	print("enter " + name)

func _update(_delta: float):
	if parent.can_attack_player:
		if parent.attack_timer.is_stopped():
			dispatch("idle_to_attack")
	elif idle_timer.is_stopped():
		if parent.player_behind(parent):
			dispatch("idle_to_turn")
		else:
			dispatch("idle_to_walk")

func _exit():
	print("exit " + name)
