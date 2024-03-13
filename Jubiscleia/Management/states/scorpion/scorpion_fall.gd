class_name ScorpionFall
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)
	scorpion.velocity.x = 0

func enter_state() -> void:
	set_physics_process(true)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if scorpion.is_on_floor():
		scorpion.fsm.change_state(scorpion.idle_state)
	
	if not scorpion.alive:
		scorpion.fsm.change_state(scorpion.death_state)
	
