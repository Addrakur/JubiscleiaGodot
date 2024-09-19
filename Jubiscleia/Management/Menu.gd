extends Control

@onready var w1_text: Label = $w1text
@onready var w2_text: Label = $w2text
@onready var parameter_settings: Control = $ParameterSettings


func on_tutorial_pressed():
	GameSettings.change_scene(Paths.tutorial)

func on_level1_pressed():
	GameSettings.change_scene(Paths.level1)

func on_level2_pressed():
	GameSettings.change_scene(Paths.level2)

func _on_level_3_pressed():
	GameSettings.change_scene(Paths.level3)

func _on_arena_pressed():
	GameSettings.change_scene(Paths.arena)

func on_quit_pressed():
	get_tree().quit()

func _on_w_1_sword_pressed():
	if PlayerVariables.skill_2 != "sword":
		PlayerVariables.skill_1 = "sword"
	else:
		PlayerVariables.skill_2 = "axe"
		PlayerVariables.skill_1 = "sword"

func _on_w_1_axe_pressed():
	if PlayerVariables.skill_2 != "axe":
		PlayerVariables.skill_1 = "axe"
	else:
		PlayerVariables.skill_2 = "sword"
		PlayerVariables.skill_1 = "axe"

func _on_w_1_spear_pressed():
	if PlayerVariables.skill_2 != "spear":
		PlayerVariables.skill_1 = "spear"
	else:
		PlayerVariables.skill_2 = "sword"
		PlayerVariables.skill_1 = "spear"

func _on_w_2_sword_pressed():
	if PlayerVariables.skill_1 != "sword":
		PlayerVariables.skill_2 = "sword"
	else:
		PlayerVariables.skill_1 = "axe"
		PlayerVariables.skill_2 = "sword"

func _on_w_2_axe_pressed():
	if PlayerVariables.skill_1 != "axe":
		PlayerVariables.skill_2 = "axe"
	else:
		PlayerVariables.skill_1 = "sword"
		PlayerVariables.skill_2 = "axe"

func _on_w_2_spear_pressed():
	if PlayerVariables.skill_1 != "spear":
		PlayerVariables.skill_2 = "spear"
	else:
		PlayerVariables.skill_1 = "sword"
		PlayerVariables.skill_2 = "spear"

func _process(_delta):
	w1_text.text = "Weapon 1 = " + PlayerVariables.skill_1
	w2_text.text = "Weapon 2 = " + PlayerVariables.skill_2


func _on_settings_pressed() -> void:
	parameter_settings.visible = true

func _on_back_pressed() -> void:
	parameter_settings.visible = false
