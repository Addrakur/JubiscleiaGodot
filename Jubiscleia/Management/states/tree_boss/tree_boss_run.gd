extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer
@export var speed_1: float
@export var speed_2: float

func _enter() -> void:
	animation.play("walk_1" if parent.fase_1 else "walk_2")
	set_dir()

func _update(delta) -> void:
	if parent.fase_1:
		parent.velocity.x = speed_1 * delta * parent.direction * parent.speed
	else:
		parent.velocity.x = speed_2 * delta * parent.direction * parent.speed
	
	match parent.next_attack:
		"swipe":
			if parent.can_attack_melee:
				dispatch("run_to_swipe")
		"throw_rock":
			if parent.can_attack_ranged:
				dispatch("run_to_throw")
		"seed_rain":
			if parent.can_rain_seed:
				dispatch("run_to_seed")

func set_dir():
	match parent.next_attack:
		"swipe":
			parent.direction = 1 if parent.player_ref.position.x > parent.position.x else -1
		"throw_rock":
			parent.direction = 1 if parent.target == parent.arena_right else -1
		"seed_rain":
			parent.direction = 1 if parent.arena_middle.position.x > parent.position.x else -1
