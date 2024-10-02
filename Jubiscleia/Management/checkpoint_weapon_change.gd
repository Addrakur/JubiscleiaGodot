class_name CheckpointWeaponChange
extends CanvasLayer

@onready var w_1_label: Label = $W1Label
@onready var w_2_label: Label = $W2Label

func _ready() -> void:
	pass

func _on_sword_1_pressed() -> void:
	if PlayerVariables.skill_2 != "sword":
		PlayerVariables.skill_1 = "sword"
	else:
		PlayerVariables.skill_2 = "axe"
		PlayerVariables.skill_1 = "sword"

func _on_sword_2_pressed() -> void:
	if PlayerVariables.skill_1 != "sword":
		PlayerVariables.skill_2 = "sword"
	else:
		PlayerVariables.skill_1 = "axe"
		PlayerVariables.skill_2 = "sword"

func _on_axe_1_pressed() -> void:
	if PlayerVariables.skill_2 != "axe":
		PlayerVariables.skill_1 = "axe"
	else:
		PlayerVariables.skill_2 = "sword"
		PlayerVariables.skill_1 = "axe"

func _on_axe_2_pressed() -> void:
	if PlayerVariables.skill_1 != "axe":
		PlayerVariables.skill_2 = "axe"
	else:
		PlayerVariables.skill_1 = "sword"
		PlayerVariables.skill_2 = "axe"

func _on_spear_1_pressed() -> void:
	if PlayerVariables.skill_2 != "spear":
		PlayerVariables.skill_1 = "spear"
	else:
		PlayerVariables.skill_2 = "sword"
		PlayerVariables.skill_1 = "spear"

func _on_spear_2_pressed() -> void:
	if PlayerVariables.skill_1 != "spear":
		PlayerVariables.skill_2 = "spear"
	else:
		PlayerVariables.skill_1 = "sword"
		PlayerVariables.skill_2 = "spear"

func _process(delta: float) -> void:
	if not visible:
		return
	
	w_1_label.text = "Weapon 1 = " + PlayerVariables.skill_1
	w_2_label.text = "Weapon 2 = " + PlayerVariables.skill_2
	
