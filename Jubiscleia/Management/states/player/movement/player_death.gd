class_name PlayerDeath
extends State

@export var player: Player
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.can_dash = false
	animation.play("dead")
	player.velocity.x = 0
	PlayerVariables.player_alive = false
	player.texture.visible = false

func exit_state() -> void:
	set_physics_process(false)

func _on_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		player.death_menu.visible = true
