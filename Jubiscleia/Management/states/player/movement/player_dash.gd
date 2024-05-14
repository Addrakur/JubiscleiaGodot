class_name PlayerDash
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.velocity.x = speed * player.direction
	player.dash_cooldown.start()
	animation.play("dash")
	player.override_gravity = 0.1
	player.velocity.y = 0

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0

func _on_animation_finished(anim):
	if anim == "dash":
		player.fsm.change_state(player.idle_state)
