extends Control

@export_group("Buttons")
@export var skill_1_change_weapon_button: TextureButton
@export var skill_1_change_element_button: TextureButton
@export var skill_1_change_attack_1_button: TextureButton
@export var skill_1_change_attack_2_button: TextureButton
@export var skill_1_change_finisher_button: TextureButton

@export var skill_2_change_weapon_button: TextureButton
@export var skill_2_change_element_button: TextureButton
@export var skill_2_change_attack_1_button: TextureButton
@export var skill_2_change_attack_2_button: TextureButton
@export var skill_2_change_finisher_button: TextureButton

@export_group("Button Arrays")
@export var skill_1_weapon_buttons: Array[TextureButton]
@export var skill_1_element_buttons: Array[TextureButton]
@export var skill_1_attack_choice_buttons: Array[TextureButton]

@export var skill_2_weapon_buttons: Array[TextureButton]
@export var skill_2_element_buttons: Array[TextureButton]
@export var skill_2_attack_choice_buttons: Array[TextureButton]

@export_group("Textures")
@export var weapon_change_button_symbols: Array[CompressedTexture2D]
@export var element_change_button_symbols: Array[CompressedTexture2D]

@onready var weapon_change_button_symbol_1: Sprite2D = $weapon_choose_activate/weapon_change_button_symbol
@onready var element_change_button_symbol_1: Sprite2D = $element_choose_activate/element_change_button_symbol
@onready var weapon_change_button_symbol_2: Sprite2D = $weapon_choose_activate2/weapon_change_button_symbol_2
@onready var element_change_button_symbol_2: Sprite2D = $element_choose_activate2/element_change_button_symbol_2
@onready var attack_options: Node = $attack_options
@onready var play_button: TextureButton = $play_button

var attack_being_changed_1: String
var attack_being_changed_2: String

func _process(_delta: float) -> void:
	
	if can_play_check():
		play_button.disabled = false
		print("enable")
	else:
		play_button.disabled = true
		print("disable")
	
	match PlayerVariables.skill_1_weapon:
		"axe":
			weapon_change_button_symbol_1.texture = weapon_change_button_symbols[0]
		"sword":
			weapon_change_button_symbol_1.texture = weapon_change_button_symbols[1]
	
	match PlayerVariables.skill_1_element:
		"air":
			element_change_button_symbol_1.texture = element_change_button_symbols[0]
		"fire":
			element_change_button_symbol_1.texture = element_change_button_symbols[1]
		"earth":
			element_change_button_symbol_1.texture = element_change_button_symbols[2]
		"water":
			element_change_button_symbol_1.texture = element_change_button_symbols[3]
		"none":
			element_change_button_symbol_1.texture = null
	
	match PlayerVariables.skill_2_weapon:
		"axe":
			weapon_change_button_symbol_2.texture = weapon_change_button_symbols[0]
		"sword":
			weapon_change_button_symbol_2.texture = weapon_change_button_symbols[1]
	
	match PlayerVariables.skill_2_element:
		"air":
			element_change_button_symbol_2.texture = element_change_button_symbols[0]
		"fire":
			element_change_button_symbol_2.texture = element_change_button_symbols[1]
		"earth":
			element_change_button_symbol_2.texture = element_change_button_symbols[2]
		"water":
			element_change_button_symbol_2.texture = element_change_button_symbols[3]
		"none":
			element_change_button_symbol_2.texture = null
	

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

func choose_attack_to_change(attack: String, button_choice: TextureButton, skill: int):
	set("attack_being_changed_" + str(skill),attack)
	for obj in get("skill_" + str(skill) + "_attack_choice_buttons"):
		if obj == button_choice:
			obj.button_pressed = true
		else:
			obj.button_pressed = false
			obj.disabled = true

func set_attack(attack_number:int, skill: int):
	PlayerVariables.set(get("attack_being_changed_" + str(skill)),attack_number)
	print(PlayerVariables.get(get("attack_being_changed_" + str(skill))))
	if get("attack_being_changed_" + str(skill)).contains("attack_1") and PlayerVariables.get("skill_" + str(skill) + "_attack_2") == attack_number:
		PlayerVariables.set("skill_" + str(skill) + "_attack_2",0)
	if get("attack_being_changed_" + str(skill)).contains("attack_2") and PlayerVariables.get("skill_" + str(skill) + "_attack_1") == attack_number:
		PlayerVariables.set("skill_" + str(skill) + "_attack_1",0)
	set("attack_being_changed_" + str(skill), "")
	for button in get("skill_" + str(skill) + "_attack_choice_buttons"):
		button.button_pressed = false
	set_texture()

func set_texture():
	for button in skill_1_attack_choice_buttons:
		button.texture_normal = button.normal_textures[PlayerVariables.get("skill_1_" + button.attack)]
		button.texture_focused = button.focus_textures[PlayerVariables.get("skill_1_" + button.attack)]
		button.texture_hover = button.focus_textures[PlayerVariables.get("skill_1_" + button.attack)]
		button.texture_disabled = button.disabled_textures[PlayerVariables.get("skill_1_" + button.attack)]
	
	for button in skill_2_attack_choice_buttons:
		button.texture_normal = button.normal_textures[PlayerVariables.get("skill_2_" + button.attack)]
		button.texture_focused = button.focus_textures[PlayerVariables.get("skill_2_" + button.attack)]
		button.texture_hover = button.focus_textures[PlayerVariables.get("skill_2_" + button.attack)]
		button.texture_disabled = button.disabled_textures[PlayerVariables.get("skill_2_" + button.attack)]
	
func reset_attacks(skill: int):
	PlayerVariables.set("skill_" + str(skill) + "_attack_1", 0)
	PlayerVariables.set("skill_" + str(skill) + "_attack_2", 0)
	PlayerVariables.set("skill_" + str(skill) + "_finisher", 0)

func _on_play_button_pressed() -> void:
	GameSettings.change_scene(Paths.get(GameSettings.next_level))

func can_play_check() -> bool:
	if PlayerVariables.skill_1_weapon == "none" or PlayerVariables.skill_2_weapon == "none" or PlayerVariables.skill_1_element == "none" or PlayerVariables.skill_2_element == "none" or PlayerVariables.skill_1_attack_1 == 0 or PlayerVariables.skill_1_attack_2 == 0 or PlayerVariables.skill_1_finisher == 0 or PlayerVariables.skill_2_attack_1 == 0 or PlayerVariables.skill_2_attack_2 == 0 or PlayerVariables.skill_2_finisher == 0:
		return false
	else:
		return true

func _on_back_button_pressed() -> void:
	GameSettings.next_level = ""
	GameSettings.change_scene(Paths.level_map)
