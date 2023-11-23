class_name VultureFly
extends State

@export var vulture: CharacterBody2D
@export var speed: float
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("fly")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	vulture.velocity.x = vulture.direction * speed
	
	if vulture.position.x > vulture.limit.limit_points[1].x:
		vulture.direction = -1
	elif vulture.position.x < vulture.limit.limit_points[0].x:
		vulture.direction = 1
	
	if vulture.health_component.is_getting_hit:
		vulture.fsm.change_state(vulture.hit_state)
	
	if!vulture.alive:
		vulture.fsm.change_state(vulture.death_state)
