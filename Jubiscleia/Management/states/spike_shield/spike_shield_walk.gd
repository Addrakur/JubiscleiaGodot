class_name SpikeShieldEnemyWalk
extends LimboState

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var speed: float
@export var wander_limit: float
@export var attack_timer: Timer

var move: bool = false

func _enter() -> void:
	animation.play("walk", -1, parent.speed)

func _exit() -> void:
	move = false
	parent.wall_cast_ground.enabled = false
	parent.wall_cast_up.enabled = false

func _update(_delta):
	if parent.player_ref != null:
		parent.new_position()
	
	if parent.move_position_behind() or parent.can_attack_player or parent.wall_cast_ground.is_colliding() or parent.wall_cast_up.is_colliding():
		dispatch("walk_to_idle")
	
	if parent.move_position != 0 and parent.direction != 0 and move:
		parent.velocity.x = parent.direction * speed
	else:
		parent.velocity.x = 0
	
	if reached_position():
		dispatch("walk_to_idle")
	
func reached_position() -> bool:
	if abs(parent.position.x - parent.move_position) < 3:
		return true
	else:
		return false

func move_true():
	move = true
	
func move_false():
	move = false

func raycast_enable():
	parent.wall_cast_ground.enabled = true
	parent.wall_cast_up.enabled = true
