class_name SnakeAttack
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

@onready var attack_collision = $"../../AttackArea/AttackCollision"

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	snake.is_attacking = true
	snake.velocity.x = 0
	animation.play("attack")

func exit_state() -> void:
	set_physics_process(false)
	snake.is_attacking = false

func _on_animation_finished(anim):
	if anim == "attack":
		if snake.can_attack_player:
			snake.fsm.change_state(snake.idle_state)
		else:
			snake.fsm.change_state(snake.chase_state)

func attack_timer_start():
	snake.attack_timer.start()
