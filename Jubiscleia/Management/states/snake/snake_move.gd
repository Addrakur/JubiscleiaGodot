class_name SnakeMove
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float
@export var limit_offset: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("run")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	snake.velocity.x = snake.direction * speed
	
	if snake.position.x > snake.limit.limit_polygon.polygon[2].x - limit_offset:
		snake.direction = -1
	elif snake.position.x < snake.limit.limit_polygon.polygon[0].x + limit_offset:
		snake.direction = 1
	
	if snake.health_component.is_getting_hit:
		snake.fsm.change_state(snake.hit_state)
	
	if snake.player_ref != null and PlayerVariables.player_alive and snake.player_on_limit:
		snake.fsm.change_state(snake.chase_state)
	
	if!snake.alive:
		snake.fsm.change_state(snake.death_state)

func chase_area_entered(body):
	if body.is_in_group("player"):
		snake.player_ref = body
