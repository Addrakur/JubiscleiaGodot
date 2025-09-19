extends TextureButton

@export var parent: Control
@export var attack: String
@export var finisher: bool

@export var normal_textures: Array[CompressedTexture2D]
@export var focus_textures: Array[CompressedTexture2D]
@export var disabled_textures: Array[CompressedTexture2D]

func _on_pressed() -> void:
	match attack:
		"1":
			if button_pressed:
				if parent.skill_1_change_attack_2_button.button_pressed or parent.skill_1_change_finisher_button.button_pressed:
					parent.skill_1_change_attack_2_button.button_pressed = false
					parent.skill_1_change_finisher_button.button_pressed = false
				parent.current_attack_being_changed = parent.skill_1_change_attack_1_button
				button_pressed = true
			else:
				button_pressed = false
				parent.current_attack_being_changed = null
		"2":
			if button_pressed:
				if parent.skill_1_change_attack_1_button.button_pressed or parent.skill_1_change_finisher_button.button_pressed:
					parent.skill_1_change_attack_1_button.button_pressed = false
					parent.skill_1_change_finisher_button.button_pressed = false
				parent.current_attack_being_changed = parent.skill_1_change_attack_2_button
				button_pressed = true
			else:
				button_pressed = false
				parent.current_attack_being_changed = null
		"finisher":
			if button_pressed:
				if parent.skill_1_change_attack_1_button.button_pressed or parent.skill_1_change_attack_2_button.button_pressed:
					parent.skill_1_change_attack_1_button.button_pressed = false
					parent.skill_1_change_attack_2_button.button_pressed = false
				parent.current_attack_being_changed = parent.skill_1_change_finisher_button
				button_pressed = true
			else:
				button_pressed = false
				parent.current_attack_being_changed = null

func change_texture(attack_number: int):
	texture_normal = normal_textures[attack_number-1]
	texture_focused = focus_textures[attack_number-1]
	texture_hover = focus_textures[attack_number-1]
	texture_disabled = disabled_textures[attack_number-1]
