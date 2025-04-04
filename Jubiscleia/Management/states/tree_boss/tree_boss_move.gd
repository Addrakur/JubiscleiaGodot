extends LimboState

@export var speed: float
@export var parent: BossTree
@export var animation: AnimationPlayer
@export var move_tree: BTPlayer

func _enter():
	move_tree.active = true
	animation.play("walk")

func _exit():
	move_tree.active = false

func _update(_delta: float) -> void:
	if not parent.player_on_limit:
		dispatch("move_to_idle")

func move(direction: float, delta: float):
	parent.velocity.x = direction * speed * delta
