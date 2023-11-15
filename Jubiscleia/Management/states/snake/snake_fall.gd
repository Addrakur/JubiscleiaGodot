class_name SnakeFall
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)
	snake.velocity.x = 0

func enter_state() -> void:
	set_physics_process(true)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if snake.is_on_floor():
		snake.fsm.change_state(snake.move_state)
	
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)
	
