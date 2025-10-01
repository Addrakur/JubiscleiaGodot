extends TextureButton

@export var parent: Control
@export var weapon: String
@export var skill: int

func _on_pressed() -> void:
	parent.set_element("none",skill)
	parent.set_weapon(weapon,skill)
	var button: TextureButton = parent.get("skill_" + str(skill) + "_change_weapon_button")
	button.button_pressed = false

func _process(_delta: float) -> void:
	var button: TextureButton = parent.get("skill_" + str(skill) + "_change_weapon_button")
	if not button.button_pressed:
		disabled = true
		return
	disabled = false
