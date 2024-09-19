class_name KitsuneWalk
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

var new_x: float

func _ready():
	set_physics_process(false)
	speed = Parameters.kitsune_walk_speed

func enter_state() -> void:
	set_physics_process(true)
	new_position()
	animation.play("walk")
	

func exit_state() -> void:
	set_physics_process(false)
	new_x = 0

func _physics_process(_delta):
	if new_x != 0:
		kitsune.velocity.x = kitsune.direction * speed
	
	if kitsune.position.x > new_x and kitsune.direction == 1 or kitsune.position.x < new_x and kitsune.direction == -1:
		kitsune.fsm.change_state(kitsune.idle_state)
	
	if kitsune.player_on_run_area and kitsune.cant_run_timer.is_stopped() and not kitsune.is_attacking and kitsune.player_on_limit:
		kitsune.fsm.change_state(kitsune.run_state)

func new_position():
	var chance: float
	chance = randf_range(0,10)
	if chance > 5:
		new_x = kitsune.starting_x.position.x + randf_range(kitsune.min_wander, kitsune.off_set_wander)
	elif chance < 5:
		new_x = kitsune.starting_x.position.x - randf_range(kitsune.min_wander, kitsune.off_set_wander)
	else:
		new_x = kitsune.starting_x.position.x
	
	if kitsune.position.x > new_x:
		kitsune.direction = -1
	else:
		kitsune.direction = 1
