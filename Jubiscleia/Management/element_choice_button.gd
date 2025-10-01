extends TextureButton

@export var parent: Control
@export var element: String
@export var skill: int

func _on_pressed() -> void:
	parent.set_element(element,skill)
	var button: TextureButton = parent.get("skill_" + str(skill) + "_change_element_button")
	button.button_pressed = false
	parent.reset_attacks(skill)

func _process(_delta: float) -> void:
	var button: TextureButton = parent.get("skill_" + str(skill) + "_change_element_button")
	if not button.button_pressed or not PlayerVariables.get(PlayerVariables.get("skill_" + str(skill) + "_weapon") + "_" + element + "_unlocked"):
		disabled = true
		return
	disabled = false
	
