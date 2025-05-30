extends LimboState

@export var parent: Rockrab
@export var animation: AnimationPlayer
@export var speed: float

var target: float

func _enter() -> void:
	animation.play("walk")
	set_target()

func _update(delta) -> void:
	parent.velocity.x = speed * delta * parent.direction * parent.speed
	
	if parent.direction == 1 and parent.position.x >= target or parent.direction == -1 and parent.position.x <= target:
		dispatch("walk_to_idle")
	
	if parent.can_attack_player or parent.player_on_chase_area:
		dispatch("walk_to_idle")

func set_target():
	target = randf_range(parent.limit.limit_polygon.polygon[1].x + parent.collision.shape.radius,parent.limit.limit_polygon.polygon[2].x - parent.collision.shape.radius)
	parent.direction = 1 if target > parent.position.x else -1
 
