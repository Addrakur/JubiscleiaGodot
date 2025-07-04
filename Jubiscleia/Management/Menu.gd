extends Control

@export var w1_text: Sprite2D
@export var w2_text: Sprite2D
@onready var parameter_settings: Control = $ParameterSettings
@onready var w_1: AnimationPlayer = $w1
@onready var w_2: AnimationPlayer = $w2
@onready var skill_tree: Control = $skill_tree


@export var weapon_1_buttons: Array[TextureButton]
@export var weapon_2_buttons: Array[TextureButton]

func _ready() -> void:
	button_pressed_manager()

func on_quit_pressed():
	get_tree().quit()

func _on_w_1_sword_pressed():
	PlayerVariables.set_skill_1("sword")
	button_pressed_manager()

func _on_w_1_axe_pressed():
	PlayerVariables.set_skill_1("axe")
	button_pressed_manager()

func _on_w_1_spear_pressed():
	PlayerVariables.set_skill_1("spear")
	button_pressed_manager()

func _on_w_2_sword_pressed():
	PlayerVariables.set_skill_2("sword")
	button_pressed_manager()

func _on_w_2_axe_pressed():
	PlayerVariables.set_skill_2("axe")
	button_pressed_manager()

func _on_w_2_spear_pressed():
	PlayerVariables.set_skill_2("spear")
	button_pressed_manager()

func _on_settings_pressed() -> void:
	parameter_settings.visible = true

func _on_back_pressed() -> void:
	parameter_settings.visible = false
	

func button_pressed_manager():
	for button in weapon_1_buttons:
		if button.name != PlayerVariables.skill_1 or not PlayerVariables.get(button.name + "_unlocked"):
			button.button_pressed = false
		else:
			button.button_pressed = true
	
	for button in weapon_2_buttons:
		if button.name != PlayerVariables.skill_2 or not PlayerVariables.get(button.name + "_unlocked"):
			button.button_pressed = false
		else:
			button.button_pressed = true
	
	w_1.play(PlayerVariables.skill_1)
	w_2.play(PlayerVariables.skill_2)
	

func _on_skill_tree_button_pressed() -> void:
	if skill_tree.visible:
		skill_tree.visible = false
	else:
		skill_tree.visible = true
