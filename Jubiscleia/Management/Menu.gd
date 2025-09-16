extends Control

@onready var skill_tree: Control = $skill_tree
@onready var w1_t: RichTextLabel = $w1_t
@onready var w2_t: RichTextLabel = $w2_t

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
	
	w1_t.text = PlayerVariables.skill_1
	w2_t.text = PlayerVariables.skill_2
	

func _on_skill_tree_button_pressed() -> void:
	if skill_tree.visible:
		skill_tree.visible = false
	else:
		skill_tree.visible = true
