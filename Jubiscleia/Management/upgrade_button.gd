class_name UpgradeButton
extends TextureButton

var skill_name: String
@export var description: String
@export var upgrades_needed: Array[UpgradeButton]

var active: bool = false
var can_upgrade: bool = false

func _ready() -> void:
	skill_name = "skill_" + name
	if SkillTree.get(skill_name):
		active = true
	else:
		active = false

func _process(_delta: float) -> void:
	if not active:
		SkillTree.set(skill_name,false)
		button_pressed = false
		if can_upgrade:
			disabled = false
		else:
			disabled = true
	else:
		button_pressed = true
		SkillTree.set(skill_name,true)
	
	if upgrades_needed != null:
		for upgrade in upgrades_needed:
			if not upgrade.active:
				if active:
					active = false
				can_upgrade = false
				return
	can_upgrade = true
	

func _on_pressed() -> void:
	if active:
		active = false
		SkillTree.set(skill_name,false)
	elif not active and can_upgrade:
		active = true
		SkillTree.set(skill_name,true)
	
