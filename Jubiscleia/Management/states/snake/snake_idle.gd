class_name SnakeIdle
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("idle")
	snake.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	
	if snake.health_component.is_getting_hit:
		snake.fsm.change_state(snake.hit_state)
	
	if not snake.can_attack_player:
		snake.fsm.change_state(snake.chase_state)
	elif snake.attack_timer.is_stopped():
		snake.fsm.change_state(snake.attack_state)
	
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)

func _on_can_attack_area_body_exited(body):
	if body == snake.player_ref:
		snake.can_attack_player = false

func _on_attack_timer_timeout():
	pass
 
