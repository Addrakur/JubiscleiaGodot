class_name PlayerIdle
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

signal idle_move
signal idle_jump
signal idle_fall

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("idle")
	player.jump_count = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.direction = Input.get_axis("left","right")
	
	if player.direction != 0 && player.is_on_floor():
		idle_move.emit()
	
	if Input.is_action_pressed("jump"):
		player.jump_count += 1
		idle_jump.emit()
	
	if player.velocity.y > 0:
		player.jump_count += 1
		idle_fall.emit()
