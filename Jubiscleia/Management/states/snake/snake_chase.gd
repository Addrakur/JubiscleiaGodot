class_name SnakeChase
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("run")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	snake.velocity.x = snake.direction * speed
	
	if snake.player_ref != null and PlayerVariables.player_alive and snake.player_on_limit:
		if snake.player_ref.position.x > snake.position.x - 10:
			snake.direction = 1
		elif snake.player_ref.position.x < snake.position.x + 10:
			snake.direction = -1
	else:
		snake.fsm.change_state(snake.move_state)
	
	if snake.can_attack_player:
		if snake.attack_timer.is_stopped():
			snake.fsm.change_state(snake.attack_state)
		else:
			snake.fsm.change_state(snake.idle_state)
