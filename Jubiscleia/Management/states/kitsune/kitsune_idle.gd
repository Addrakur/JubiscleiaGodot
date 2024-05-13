class_name KitsuneIdle
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer
@export var idle_timer: Timer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	idle_timer.start()
	set_physics_process(true)
	animation.play("idle")
	kitsune.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if kitsune.player_ref == null:
		if idle_timer.is_stopped():
			kitsune.fsm.change_state(kitsune.walk_state)
	else:
		kitsune.direction = 1 if kitsune.position.x < kitsune.player_ref.position.x else -1
	
	if kitsune.player_on_run_area and kitsune.cant_run_timer.is_stopped():
		kitsune.fsm.change_state(kitsune.run_state)
