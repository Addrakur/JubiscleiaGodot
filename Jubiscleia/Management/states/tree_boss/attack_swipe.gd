extends LimboState

@export var speed_1: float
@export var speed_2: float
@export var parent:  BossTree
@export var tree: BTPlayer

var speed: float

var move: bool = false
var dir: float
@export var move_speed: float

func _enter() -> void:
	if parent.fase_1:
		speed = speed_1
	else:
		speed = speed_2
	
	tree.active = true

func _update(delta) -> void:
	if move:
		parent.velocity.x = move_speed * dir * delta
	else:
		parent.velocity.x = 0

func _exit() -> void:
	tree.active = false

func set_move(t_or_f: bool):
	move = t_or_f

func set_direction():
	if parent.player_ref.position.x > parent.position.x:
		dir = 1
	else:
		dir = -1
