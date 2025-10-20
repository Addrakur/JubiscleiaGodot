extends LimboState

@export var parent: LightningDash
@export var animation: AnimationPlayer
@export var speed: float

func _enter() -> void:
	random_direction()
	animation.play("walk")

func _update(delta) -> void:
	parent.velocity.x = speed * delta * parent.direction * parent.speed
	
	if parent.direction == 1 and parent.global_position.x > parent.starting_x.global_position.x + parent.max_wandering_distance or parent.direction == 1 and parent.is_on_wall_raycast.scale.x == -1 and parent.is_on_wall_raycast.is_colliding():
		parent.direction = -1
	elif parent.direction == -1 and parent.global_position.x < parent.starting_x.global_position.x - parent.max_wandering_distance or parent.direction == -1 and parent.is_on_wall_raycast.scale.x == 1 and parent.is_on_wall_raycast.is_colliding():
		parent.direction = 1
	
	if parent.velocity.x < 0:
		parent.left()
	elif parent.velocity.x > 0:
		parent.right()
	
	if parent.can_attack_player:
		dispatch("walk_to_attack")

func random_direction():
	var chance: float
	chance = randf_range(0,10)
	if chance > 5:
		parent.direction = 1
	else:
		parent.direction = -1
