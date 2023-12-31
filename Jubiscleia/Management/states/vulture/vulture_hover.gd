class_name VultureHover
extends State

@export var vulture: CharacterBody2D
@export var animation: AnimationPlayer

var side: String

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
	stay_on_hover_point()
	
	if !vulture.alive:
		vulture.fsm.change_state(vulture.death_state)

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
		vulture.attack_timer.start()
		vulture.attack_state.player_location = vulture.player_ref.position
		if side == "left":
			vulture.attack_state.end_location = Vector2(vulture.position.x - 128,vulture.y)
		else:
			vulture.attack_state.end_location = Vector2(vulture.position.x + 128,vulture.y)
		vulture.fsm.change_state(vulture.attack_state)

func stay_on_hover_point():
	if vulture.player_ref.position.x < vulture.position.x:
		vulture.position.x = vulture.player_ref.position.x + vulture.hover_offset
		vulture.left()
		side = "left"
	elif vulture.player_ref.position.x > vulture.position.x:
		vulture.position.x = vulture.player_ref.position.x - vulture.hover_offset
		vulture.right()
		side = "right"

func detect_area_body_exited(body):
	if body == vulture.player_ref:
		vulture.player_ref = null
