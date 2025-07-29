extends LimboState

@export var parent: Stalac
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var can_rotate: bool = false

func _enter():
	parent.velocity.x = 0
	#animation.play("attack")
	set_direction()
	print("attack")

func _update(delta) -> void:
	if can_rotate:
		rotate_to_target(delta)
	
	if parent.direction == 1 and parent.texture.rotation_degrees >= 90 or parent.direction == -1 and parent.texture.rotation_degrees <= -90:
		can_rotate = false

func _exit():
	parent.can_attack = false
	print("exit attack")
	#attack_timer.start()

func rotate_to_target(delta: float):
	parent.texture.rotation_degrees += 1 * parent.direction

func set_direction():
	if parent.player_ref.position.x > parent.position.x:
		parent.direction = 1
	else:
		parent.direction = -1
	can_rotate = true

func _on_animation_animation_finished(anim_name: StringName) -> void:
	pass
	#if anim_name == "attack":
		#dispatch("attack_to_idle")
