class_name SnakeMove
extends State

@export var snake: Snake
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
	snake.velocity.x = snake.direction * speed * snake.speed
	
	if snake.position.x > snake.limit.limit_polygon.polygon[2].x - limit_offset:
		snake.direction = -1
	elif snake.position.x < snake.limit.limit_polygon.polygon[0].x + limit_offset:
		snake.direction = 1
	
	if snake.player_ref != null and PlayerVariables.player_alive and snake.player_on_limit:
		snake.fsm.change_state(snake.chase_state)
	
