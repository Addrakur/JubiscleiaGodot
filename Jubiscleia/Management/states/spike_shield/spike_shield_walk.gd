class_name SpikeShieldEnemyWalk
extends LimboState

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var speed: float
@export var wander_limit: float
@export var attack_timer: Timer

var new_x: float

var move: bool = false

func _enter() -> void:
	new_position()
	animation.play("walk",-1,0.9)
	
	print("enter " + name)

func _exit() -> void:
	new_x = 0
	
	print("exit " + name)

func _update(_delta):
	
	if parent.player_behind(parent) or parent.can_attack_player:
		dispatch("walk_to_idle")
	
	if new_x != 0 and parent.direction != 0 and move:
		parent.velocity.x = parent.direction * speed
	else:
		parent.velocity.x = 0
	
	if abs(parent.position.x - new_x) < 10:
		dispatch("walk_to_idle")

func new_position():
	if parent.player_ref == null:
		new_x = randf_range(parent.limit.limit_polygon.polygon[0].x + wander_limit, parent.limit.limit_polygon.polygon[2].x - wander_limit)
	else:
		new_x = parent.player_ref.position.x
	
	if parent.position.x > new_x:
		parent.direction = -1
	else:
		parent.direction = 1
	
func move_true():
	move = true
	
func move_false():
	move = false
