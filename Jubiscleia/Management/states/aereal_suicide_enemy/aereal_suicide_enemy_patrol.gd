class_name AerealSuicideEnemyPatrol
extends LimboState

@export var parent: AerealSuicideEnemy
@export var animation: AnimationPlayer
@export var raycast_left: RayCast2D
@export var raycast_right: RayCast2D
@export var speed: float
@export var tolerance: float


#var direction: float

func _enter():
	#random_direction()
	animation.play("patrol")

func _update(_delta: float) -> void:
	parent.position.y = parent.fixed_y
	parent.velocity.x = speed * parent.direction
	turn_around()
	
	if not parent.player_on_limit:
		return
	
	if raycast_left.is_colliding() or raycast_right.is_colliding():
		dispatch("patrol_to_attack")

#func random_direction():
	#direction = randi_range(-1,1)
	#if direction == 0:
		#random_direction()

func turn_around():
	if parent.direction == 1 and abs(parent.global_position.x - parent.point_right.position.x) < tolerance or parent.direction == -1 and abs(parent.global_position.x - parent.point_left.position.x) < tolerance:
		parent.direction *= -1
