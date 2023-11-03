class_name SnakeMove
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
	
	if snake.health_component.is_getting_hit:
		snake.fsm.change_state(snake.hit_state)
	
	if snake.player_ref != null and GameSettings.player_alive:
		if snake.direction == 1 and snake.player_ref.position.x > snake.position.x or snake.direction == -1 and snake.player_ref.position.x > snake.position.x:
			snake.right()
			if snake.attack_timer.is_stopped():
				snake.fsm.change_state(snake.attack_state)
			else:
				snake.fsm.change_state(snake.idle_state)
		else:
			snake.left()
			if snake.attack_timer.is_stopped():
				snake.fsm.change_state(snake.attack_state)
			else:
				snake.fsm.change_state(snake.idle_state)
	
	if!snake.alive:
		snake.fsm.change_state(snake.death_state)

func _on_can_attack_area_body_entered(body):
	if body.is_in_group("player") and GameSettings.player_alive:
		snake.player_ref = body
