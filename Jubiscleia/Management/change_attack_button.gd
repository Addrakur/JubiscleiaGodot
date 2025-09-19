extends TextureButton

@export var parent: Control
@export var finisher: bool
@export var number: int

func _on_pressed() -> void:
	if not finisher:
		PlayerVariables.set("skill_1_attack_" + parent.current_attack_being_changed.attack,number)
	else:
		PlayerVariables.skill_1_finisher = number
	parent.current_attack_being_changed.change_texture(number)
	parent.current_attack_being_changed.button_pressed = false
	
	for button in parent.skill_1_attack_buttons:
		if button.name != name:
			button.button_pressed = false
	
