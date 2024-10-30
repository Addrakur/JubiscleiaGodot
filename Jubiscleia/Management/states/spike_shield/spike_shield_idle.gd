class_name SpikeShieldEnemyIdle
extends LimboState

@export var parent: SpikeShieldEnemy
@export var idle_timer: Timer
@export var attack_timer: Timer
@export var animation: AnimationPlayer

func _enter() -> void:
	idle_timer.start()
	animation.play("idle")
	parent.velocity.x = 0
	print("enter " + name)

func _update(_delta: float):
	if attack_timer.is_stopped():
		if parent.can_attack_player:
			dispatch("idle_to_attack")
		elif parent.turn_attack:
			dispatch("idle_to_turn")

func _exit():
	print("exit " + name)

func _on_idle_timer_timeout() -> void:
	if parent.hsm.get_active_state() == self:
		parent.new_position()
		parent.set_direction()
		
		if parent.move_position_behind():
			dispatch("idle_to_turn")
		else:
			dispatch("idle_to_walk")
