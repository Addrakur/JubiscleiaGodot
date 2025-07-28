extends LimboState

@export var parent: Stalac
@export var animation: AnimationPlayer

func _enter():
	parent.velocity.x = 0
	animation.play("attack")
	#set_direction()
	#rotate_to_target()
	print("attack")

func _exit():
	pass

func _update(_delta) -> void:
	pass

func rotate_to_target():
	parent.texture.rotation_degrees = 90 * parent.rotation

func set_direction():
	if parent.player_ref.position.x > parent.position.x:
		parent.direction = 1
	else:
		parent.direction = -1
