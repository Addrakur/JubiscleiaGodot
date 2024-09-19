class_name CameraMethods
extends Node2D

@export var parent: Player

var weapon_shake: bool = false
var general_shake: bool = false

func weapon_camera_shake():
	var shake_amount = Vector2(randf_range(-1,1),randf_range(-1,1)) * PlayerVariables.get(PlayerVariables.current_attack + "_shake")
	parent.camera.offset = shake_amount

func general_camera_shake():
	pass

func _process(_delta: float) -> void:
	if general_shake:
		general_camera_shake()
	elif weapon_shake:
		weapon_camera_shake()

func weapon_shake_true():
	weapon_shake = true

func weapon_shake_false():
	weapon_shake = false
	parent.camera.offset = Vector2.ZERO
