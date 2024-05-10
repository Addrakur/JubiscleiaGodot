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
	
	if snake.player_ref == null:
		snake.fsm.change_state(snake.move_state)
	
	if not snake.can_attack_player:
		snake.fsm.change_state(snake.chase_state)
	elif snake.attack_timer.is_stopped():
		snake.fsm.change_state(snake.attack_state)

func _on_attack_timer_timeout():
	pass
