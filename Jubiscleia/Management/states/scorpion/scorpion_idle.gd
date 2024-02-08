class_name ScorpionIdle
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer
@export var idle_timer: Timer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	idle_timer.start()
	set_physics_process(true)
	animation.play("idle")
	scorpion.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if idle_timer.is_stopped():
		scorpion.fsm.change_state(scorpion.walk_state)
	
	if scorpion.player_ref != null and scorpion.player_on_limit and scorpion.attack_timer.is_stopped():
		scorpion.fsm.change_state(scorpion.attack_state)

