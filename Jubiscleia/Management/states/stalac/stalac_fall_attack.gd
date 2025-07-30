extends LimboState

@export var parent: Stalac
@export var fall_speed: float

func _enter():
	pass

func _exit():
	parent.position.y += 40
	parent.rotation_degrees = 0

func _update(delta) -> void:
	parent.velocity.y = fall_speed * delta
	if parent.is_on_floor():
		dispatch("fall_attack_to_idle")
