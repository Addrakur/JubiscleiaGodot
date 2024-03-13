class_name PlayerDash
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

var direction: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.dash_cooldown.start()
	direction = player.last_direction
	animation.play("dash")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = speed * direction
	player.velocity.y = 0

func _on_animation_finished(anim):
	if anim == "dash":
		player.fsm.change_state(player.idle_state)
