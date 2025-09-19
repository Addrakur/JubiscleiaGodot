extends Control

@export_group("Buttons")
@export var skill_1_change_weapon_button: TextureButton
@export var skill_1_change_element_button: TextureButton
@export var skill_1_change_attack_1_button: TextureButton
@export var skill_1_change_attack_2_button: TextureButton
@export var skill_1_change_finisher_button: TextureButton

@export_group("Button Arrays")
@export var skill_1_weapon_buttons: Array[TextureButton]
@export var skill_1_element_buttons: Array[TextureButton]
@export var skill_1_attack_buttons: Array[TextureButton]
@export var skill_1_finisher_buttons: Array[TextureButton]

@export_group("Textures")
@export var weapon_change_button_symbols_1: Array[CompressedTexture2D]

@onready var weapon_change_button_symbol_1: Sprite2D = $weapon_choose_activate/weapon_change_button_symbol

var current_attack_being_changed: TextureButton

func _process(_delta: float) -> void:
	for button in skill_1_weapon_buttons:
		if skill_1_change_weapon_button.button_pressed:
			button.disabled = false
		else:
			button.disabled = true
	
	for button in skill_1_element_buttons:
		if skill_1_change_element_button.button_pressed:
			if PlayerVariables.get(PlayerVariables.skill_1_weapon + "_" + button.element + "_unlocked"):
				button.disabled = false
			else:
				button.disabled = true
		else:
			button.disabled = true
	
	if PlayerVariables.skill_1_weapon == "none" or PlayerVariables.skill_1_element == "none":
		skill_1_change_attack_1_button.disabled = true
		skill_1_change_attack_2_button.disabled = true
		skill_1_change_finisher_button.disabled = true
	else:
		skill_1_change_attack_1_button.disabled = false
		skill_1_change_attack_2_button.disabled = false
		skill_1_change_finisher_button.disabled = false
	
	for button in skill_1_attack_buttons:
		if skill_1_change_attack_1_button.button_pressed or skill_1_change_attack_2_button.button_pressed:
			if PlayerVariables.get(PlayerVariables.skill_1_weapon + "_" + PlayerVariables.skill_1_element + "_" + str(button.number)):
				button.disabled = false
			else:
				button.disabled = true
		else:
			button.disabled = true
	
	for button in skill_1_finisher_buttons:
		if skill_1_change_finisher_button.button_pressed:
			if PlayerVariables.get(PlayerVariables.skill_1_weapon + "_" + PlayerVariables.skill_1_element + "_finisher_" + str(button.number)):
				button.disabled = false
			else:
				button.disabled = true
		else:
			button.disabled = true
	
	match PlayerVariables.skill_1_weapon:
		"axe":
			weapon_change_button_symbol_1.texture = weapon_change_button_symbols_1[0]
		"sword":
			weapon_change_button_symbol_1.texture = weapon_change_button_symbols_1[1]
	

func set_weapon(weapon: String, skill: int):
	PlayerVariables.set("skill_" + str(skill) + "_weapon", weapon)
	for button in get("skill_" + str(skill) + "_weapon_buttons"):
		if button.weapon != weapon:
			button.button_pressed = false

func set_element(element: String, skill: int):
	PlayerVariables.set("skill_" + str(skill) + "_element", element)
	for button in get("skill_" + str(skill) + "_element_buttons"):
		if button.element != element:
			button.button_pressed = false

func reset_elements():
	PlayerVariables.skill_1_element = "none"
	for button in skill_1_element_buttons:
		button.button_pressed = false
