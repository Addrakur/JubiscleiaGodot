extends LimboState

@export var parent: Stalac
@export var fall_speed: float
@export var attack_timer: Timer
@export var turn_timer: Timer

func _enter():
	pass

func _exit():
	attack_timer.start()

func _update(delta) -> void:
	if turn_timer.is_stopped():
		parent.velocity.y = fall_speed * delta
		if parent.is_on_floor():
			turn_timer.start()

func _on_turn_timer_timeout() -> void:
	parent.position.y += 40
	parent.rotation_degrees = 0
	dispatch("fall_attack_to_idle")
