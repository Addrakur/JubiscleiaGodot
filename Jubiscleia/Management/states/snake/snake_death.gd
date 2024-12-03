class_name SnakeDeath
extends State

@export var snake: Snake
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("dead")
	snake.limit.erase(snake)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	snake.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "dead":
		snake.queue_free()
