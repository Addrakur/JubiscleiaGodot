class_name SnakeHit
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	snake.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)

func _on_animation_finished(anim):
	if anim == "hit":
		snake.health_component.is_getting_hit = false
		snake.fsm.change_state(snake.move_state)
