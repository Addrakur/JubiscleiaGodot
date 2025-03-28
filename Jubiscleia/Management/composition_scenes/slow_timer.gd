class_name SlowTimer
extends Timer

var parent: Node2D

var material: ShaderMaterial

func _ready() -> void:
	parent = get_parent()
	material = parent.texture.get_material()
	material.set_shader_parameter("blue_value",0.4)

func _on_timeout() -> void:
	parent.speed = 1
	material.set_shader_parameter("blue_value",0.0)
