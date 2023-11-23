class_name VultureIdle
extends State

@export var vulture: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("idle")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	
	if vulture.health_component.is_getting_hit:
		vulture.fsm.change_state(vulture.hit_state)
	
	if!vulture.alive:
		vulture.fsm.change_state(vulture.death_state)
