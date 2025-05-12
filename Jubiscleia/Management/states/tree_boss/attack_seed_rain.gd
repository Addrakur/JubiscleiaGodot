extends LimboState

@export var parent: BossTree
@export var speed: float
@export var tree: BTPlayer
@export var animation: AnimationPlayer

func _enter() -> void:
	parent.target = parent.arena_middle
	tree.active = true

func _exit() -> void:
	tree.active = false
