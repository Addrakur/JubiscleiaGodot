extends LimboState

@export var parent: FireReaper
@export var animation: AnimationPlayer
@export var speed: float
@export var anim_speed_mult: float

var target: float

func _enter() -> void:
	animation.play("walk",-1,anim_speed_mult,false)

func _update(delta) -> void:
	if parent.can_attack_player or parent.player_ref == null or not parent.player_on_limit:
		dispatch("chase_to_idle")
	set_direction()
	parent.velocity.x = speed * delta * parent.direction * parent.speed

func _exit() -> void:
	parent.velocity.x = 0

func set_direction():
	if parent.player_ref.position.x > parent.position.x:
		parent.direction = 1
	else:
		parent.direction = -1 
