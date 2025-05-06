class_name CheckpointWeaponChange
extends CanvasLayer

@onready var w_1_label: Label = $W1Label
@onready var w_2_label: Label = $W2Label
@onready var panel: Panel = $Panel

func _ready() -> void:
	pass

func _on_sword_1_pressed() -> void:
	PlayerVariables.set_skill_1("sword")

func _on_sword_2_pressed() -> void:
	PlayerVariables.set_skill_2("sword")

func _on_axe_1_pressed() -> void:
	PlayerVariables.set_skill_1("axe")

func _on_axe_2_pressed() -> void:
	PlayerVariables.set_skill_2("axe")

func _on_spear_1_pressed() -> void:
	PlayerVariables.set_skill_1("spear")

func _on_spear_2_pressed() -> void:
	PlayerVariables.set_skill_2("spear")

func _process(_delta: float) -> void:
	if not visible:
		return
	
	w_1_label.text = "Weapon 1 = " + PlayerVariables.skill_1
	w_2_label.text = "Weapon 2 = " + PlayerVariables.skill_2

func _on_visibility_changed() -> void:
	if not visible:
		return
	var children = panel.get_children()
	for child in children:
		if child is Button:
			if PlayerVariables.get(child.name.rstrip("2") + "_unlocked"):
				child.disabled = false
			else:
				child.disabled = true
