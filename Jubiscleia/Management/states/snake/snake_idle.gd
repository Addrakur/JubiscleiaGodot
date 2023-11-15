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
	
	if snake.player_ref == null or !GameSettings.player_alive:
		snake.fsm.change_state(snake.move_state)
	
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)
	
func _process(_delta):
	if snake.is_on_wall():
		snake.direction *= -1

func _on_can_attack_area_body_exited(body):
	if body == snake.player_ref:
		snake.player_ref = null

func _on_attack_timer_timeout():
	if snake.player_ref != null:
		snake.fsm.change_state(snake.attack_state)
