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
	
	if snake.health_component.is_getting_hit:
		snake.fsm.change_state(snake.hit_state)
	
	if snake.player_ref != null and PlayerVariables.player_alive:
		if snake.player_ref.position.x > snake.position.x:
			snake.direction = 1
		else:
			snake.direction = -1
	else:
		snake.fsm.change_state(snake.move_state)
	
	if!snake.alive:
		snake.fsm.change_state(snake.death_state)

func _on_can_attack_area_body_entered(body):
	if body == snake.player_ref:
		snake.can_attack_player = true
		if snake.attack_timer.is_stopped():
			snake.fsm.change_state(snake.attack_state)
		else:
			snake.fsm.change_state(snake.idle_state)

func chase_area_exited(body):
	if body == snake.player_ref:
		snake.player_ref = null
