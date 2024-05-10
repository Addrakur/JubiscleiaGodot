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

func exit_state() -> void:
	set_physics_process(false)

func _on_animation_finished(anim):
	if anim == "dash":
		player.fsm.change_state(player.idle_state)
