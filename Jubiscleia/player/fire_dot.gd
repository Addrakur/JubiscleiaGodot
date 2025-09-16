class_name FireDot
extends Timer

var parent: Node2D
@onready var cooldown: Timer = $cooldown

var shader: ShaderMaterial

var damage: float

func _ready() -> void:
	parent = get_parent()
	shader = parent.texture.get_material()
	shader.set_shader_parameter("red_value",0.4)

func _process(_delta: float) -> void:
	if not parent.alive:
		shader.set_shader_parameter("red_value",0.0)
		queue_free()

func _on_cooldown_timeout() -> void:
	if parent.health_component != null:
		parent.health_component.update_health(damage, 0, 0, name, 0, 0, null)

func _on_timeout() -> void:
	shader.set_shader_parameter("red_value",0.0)
	queue_free()
