class_name PlayerDash
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

var direction: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	player.set_collision_mask_value(7,false)
	player.floor_snap_length = 0
	player.can_dash = false
	set_physics_process(true)
	if player.direction != 0:
		direction = player.direction
	elif player.is_on_floor():
		direction = -player.last_direction
	else:
		direction = player.last_direction
	player.dash_cooldown.start()
	animation.play("dash")
	player.override_gravity = 0.1
	player.velocity.y = 0

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0
	player.floor_snap_length = 5
	player.set_collision_mask_value(7,true)

func _physics_process(_delta):
	if PlayerVariables.move:
		player.velocity.x = speed * direction

func _on_animation_finished(anim):
	if anim == "dash":
		if player.is_on_floor():
			player.fsm.change_state(player.idle_state)
		else:
			player.fsm.change_state(player.fall_state)
