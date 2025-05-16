extends LimboState

@export var speed_1: float
@export var speed_2: float
@export var parent:  BossTree
@export var tree: BTPlayer

var speed: float

func _enter() -> void:
	if parent.fase_1:
		speed = speed_1
	else:
		speed = speed_2
	
	tree.active = true

func _exit() -> void:
	tree.active = false
