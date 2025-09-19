extends TextureButton

@export var parent: Control
@export var element: String
@export var skill: int

func _on_pressed() -> void:
	parent.set_element(element,skill)
