extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer
@export var tree: BTPlayer

func _enter():
	print("enter idle")
	tree.active = true
	animation.play("idle")

func _exit():
	print("exit idle")
	tree.active = false
