extends LimboState

@export var parent: Stalac
@export var animation: AnimationPlayer
@export var attack_timer: Timer
@export var dash_speed: float


var can_rotate: bool = false
var can_move: bool = false

func _enter():
	parent.velocity.x = 0
	animation.play("attack")
	set_direction()
	print("attack")

func _update(delta) -> void:
	if can_rotate:
		rotate_to_target(delta)
	
	if can_move:
		parent.velocity.x = dash_speed * parent.direction * delta
	
	if parent.direction == 1 and parent.texture.rotation_degrees >= 90 or parent.direction == -1 and parent.texture.rotation_degrees <= -90:
		can_rotate = false

func _exit():
	parent.can_attack = false
	print("exit attack")
	parent.texture.rotation_degrees = 0
	attack_timer.start()

func rotate_to_target(delta: float):
	parent.texture.rotation_degrees += 200 * parent.direction * delta

func set_direction():
	if parent.player_ref.position.x > parent.position.x:
		parent.direction = 1
	else:
		parent.direction = -1
	can_rotate = true

func _on_animation_animation_finished(anim_name: StringName) -> void:
	pass
	if anim_name == "attack":
		dispatch("attack_to_idle")

func can_move_toggle(t_or_f: bool):
	can_move = t_or_f
