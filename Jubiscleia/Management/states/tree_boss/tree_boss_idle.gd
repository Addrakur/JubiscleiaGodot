extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer
@export var tree: BTPlayer

func _enter():
	tree.active = true
	animation.play("idle_1")

func _exit():
	tree.active = false
