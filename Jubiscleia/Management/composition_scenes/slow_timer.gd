class_name SlowTimer
extends Timer

var parent: Node2D

var shader: ShaderMaterial

func _ready() -> void:
	parent = get_parent()
	shader = parent.texture.get_material()
	shader.set_shader_parameter("blue_value",0.4)
	parent.speed = 0.5 if parent.element == "fire" else 0.7
	parent.velocity = Vector2(parent.velocity.x * 0.5 if parent.element == "fire" else 0.7,parent.velocity.y * 0.5 if parent.element == "fire" else 0.7)

func _on_timeout() -> void:
	parent.speed = 1
	shader.set_shader_parameter("blue_value",0.0)
