class_name VultureTransition
extends State

@export var vulture: CharacterBody2D
@export var speed: float
@export var animation: AnimationPlayer

var transition_location: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("fly")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	#if vulture.player_ref.position.x > vulture.position.x and vulture.position.x < vulture.hover_offset or vulture.player_ref.position.x < vulture.position.x and vulture.position.x > vulture.hover_offset:
	#	vulture.direction = 1
	#else:
	#	vulture.direction = -1
	
	vulture.velocity.x = vulture.direction * speed * delta
	
	if vulture.health_component.is_getting_hit:
		vulture.fsm.change_state(vulture.hit_state)
	
	if!vulture.alive:
		vulture.fsm.change_state(vulture.death_state)
