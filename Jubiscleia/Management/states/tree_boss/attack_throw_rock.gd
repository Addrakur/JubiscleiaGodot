extends LimboState

@export var parent: BossTree
@export var speed: float
@export var tree: BTPlayer
@export var animation: AnimationPlayer

func _enter() -> void:
	if parent.player_ref.position.x > parent.position.x:
		parent.target = parent.arena_left
	else:
		parent.target = parent.arena_right
	tree.active = true

func _exit() -> void:
	tree.active = false

func _update(_delta) -> void:
	if parent.can_attack_ranged and animation.current_animation != "rock_throw":
		if parent.player.position.x > parent.position.x:
			parent.right()
		else:
			parent.left()
