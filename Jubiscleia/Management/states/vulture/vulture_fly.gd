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
	
	if vulture.player_ref != null and PlayerVariables.player_alive and vulture.player_on_limit and vulture.player_ref.position.y > vulture.position.y:
		vulture.attack_timer.start()
		vulture.fsm.change_state(vulture.hover_state)
	
	if vulture.position.x > vulture.limit.limit_points[1].x:
		vulture.direction = -1
	elif vulture.position.x < vulture.limit.limit_points[0].x:
		vulture.direction = 1
	
	if!vulture.alive:
		vulture.fsm.change_state(vulture.death_state)

func detect_area_body_entered(body):
	if body.is_in_group("player"):
		vulture.player_ref = body
