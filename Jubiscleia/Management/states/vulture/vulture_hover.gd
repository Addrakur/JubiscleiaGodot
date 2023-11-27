class_name VultureHover
extends State

@export var vulture: CharacterBody2D
@export var animation: AnimationPlayer
@export var hover_offset: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("fly")
	vulture.hover = true

func exit_state() -> void:
	set_physics_process(false)
	vulture.hover = false

func _physics_process(_delta):
	go_to_hover_point()
	
	if vulture.health_component.is_getting_hit:
		vulture.fsm.change_state(vulture.hit_state)
	
	if !vulture.alive:
		vulture.fsm.change_state(vulture.death_state)
	
	#if vulture.player_ref == null or not PlayerVariables.player_alive or not vulture.player_on_limit:
	#	if vulture.position.x > vulture.limit.limit_points[1].x:
	#		vulture.transition_state.transition_location = Vector2(vulture.limit.limit_points[1].x - 10,vulture.y)
	#		vulture.fsm.change_state(vulture.transition_state)
	#	elif vulture.position.x < vulture.limit.limit_points[0].x:
	#		vulture.transition_state.transition_location = Vector2(vulture.limit.limit_points[0].x + 10,vulture.y)
	#		vulture.fsm.change_state(vulture.transition_state)
	#	else:
	#		vulture.fsm.change_state(vulture.fly_state)
	
	if not PlayerVariables.player_alive or not vulture.player_on_limit:
		if vulture.position.x > vulture.limit.limit_points[1].x:
			vulture.direction = -1
			vulture.fsm.change_state(vulture.fly_state)
		elif vulture.position.x < vulture.limit.limit_points[0].x:
			vulture.direction = 1
			vulture.fsm.change_state(vulture.fly_state)
		else:
			vulture.fsm.change_state(vulture.fly_state)
	
	
	if vulture.attack_timer.is_stopped():
		print("attack")
		vulture.attack_timer.start()

func go_to_hover_point():
	if vulture.player_ref.position.x < vulture.position.x:
		vulture.position.x = vulture.player_ref.position.x + hover_offset
		vulture.left()
	elif vulture.player_ref.position.x > vulture.position.x:
		vulture.position.x = vulture.player_ref.position.x - hover_offset
		vulture.right()

func detect_area_body_exited(body):
	if body == vulture.player_ref:
		vulture.player_ref = null