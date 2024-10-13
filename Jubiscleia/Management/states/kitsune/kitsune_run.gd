class_name KitsuneRun
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float
@export var run_timer: Timer

func _ready():
	set_physics_process(false)
	speed = Parameters.kitsune_run_speed
	run_timer.wait_time = Parameters.kitsune_run_duration

func enter_state() -> void:
	run_timer.start()
	set_physics_process(true)
	animation.play("run")
	

func exit_state() -> void:
	set_physics_process(false)
	kitsune.cant_run_timer.start()

func _physics_process(_delta):
	if kitsune.player_ref != null:
		direction_fix()
	
	kitsune.velocity.x = kitsune.direction * speed
	
	if run_timer.is_stopped() or kitsune.wall_sensor.is_colliding() or kitsune.player_ref == null:
		kitsune.fsm.change_state(kitsune.idle_state)

func direction_fix():
	if kitsune.player_ref.position.x > kitsune.position.x:
		kitsune.direction = -1
	else:
		kitsune.direction = 1
