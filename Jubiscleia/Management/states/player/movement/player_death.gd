class_name PlayerDeath
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("dead")
	player.velocity.x = 0
	GameSettings.player_alive = false

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	pass
