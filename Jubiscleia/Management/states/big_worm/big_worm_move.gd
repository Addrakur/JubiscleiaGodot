class_name BigWormMove
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float
@export var limit_offset: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("walk")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	big_worm.velocity.x = big_worm.direction * speed
	
	if big_worm.position.x > big_worm.limit.limit_points[1].x - limit_offset:
		big_worm.direction = -1
	elif big_worm.position.x < big_worm.limit.limit_points[0].x + limit_offset:
		big_worm.direction = 1
	
	if big_worm.player_ref != null and PlayerVariables.player_alive and big_worm.player_on_limit:
		if big_worm.attack_timer.is_stopped():
			big_worm.fsm.change_state(big_worm.attack_state)
		else:
			big_worm.fsm.change_state(big_worm.idle_state)
	
	if big_worm.health_component.is_getting_hit:
		big_worm.fsm.change_state(big_worm.hit_state)
	
	if not big_worm.alive:
		big_worm.fsm.change_state(big_worm.death_state)

func can_attack_area_entered(body):
	if body.is_in_group("player"):
		big_worm.player_ref = body
