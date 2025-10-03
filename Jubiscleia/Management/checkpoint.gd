class_name Checkpoint
extends Node2D

@export var level: Level

@onready var animation: AnimationPlayer = $animation
@onready var checkpoint_weapon_change: CheckpointWeaponChange = $checkpoint_weapon_change

var activated: bool = false

func _ready() -> void:
	if activated:
		animation.play("active")
	else:
		animation.play("not_active")

func _on_player_collision_body_entered(body: Node2D) -> void:
	if body == PlayerVariables.player:
		#checkpoint_weapon_change.visible = true
		PlayerVariables.can_attack = false
		if not activated:
			activated = true
			PlayerVariables.player.health_component.current_health = PlayerVariables.player.health_component.max_health
			play_animation("activating")
			GameSettings.set(level.name + "_spawn_point", position)

func play_animation(anim_name: String):
	animation.play(anim_name)

func _on_player_collision_body_exited(body: Node2D) -> void:
	if body == PlayerVariables.player:
		#checkpoint_weapon_change.visible = false
		PlayerVariables.can_attack = true
