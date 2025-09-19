extends TextureButton

@export var parent: Control
@export var weapon: String
@export var skill: int

func _on_pressed() -> void:
	parent.reset_elements()
	parent.set_weapon(weapon,skill)
