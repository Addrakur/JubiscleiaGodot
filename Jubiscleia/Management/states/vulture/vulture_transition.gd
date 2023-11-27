class_name VultureTransition
extends State

@export var vulture: CharacterBody2D
@export var speed: float
@export var animation: AnimationPlayer

var transition_location: Vector2

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("fly")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	var direction: Vector2 = (transition_location-vulture.position).normalized()
	
	vulture.velocity = direction * speed * delta
	
	if vulture.position.x > vulture.limit.limit_points[1].x or vulture.position.x < vulture.limit.limit_points[0].x:
		vulture.fsm.change_state(vulture.fly_state)
	
	if vulture.health_component.is_getting_hit:
		vulture.fsm.change_state(vulture.hit_state)
	
	if!vulture.alive:
		vulture.fsm.change_state(vulture.death_state)
