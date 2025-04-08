extends LimboState

@export var speed: float
@export var parent:  BossTree
@export var tree: BTPlayer

func _enter() -> void:
	print("enter swipe")
	tree.active = true

func _exit() -> void:
	print("exit swipe")
	tree.active = false
