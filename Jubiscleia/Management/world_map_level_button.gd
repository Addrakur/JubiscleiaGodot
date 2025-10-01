class_name WorldMapLevelButton
extends TextureButton

@export var level_name: String
@export var no_required_levels: bool
@export var required_levels: Array[WorldMapLevelButton]

func _ready() -> void:
	if not no_required_levels:
		for level in required_levels:
			if not GameSettings.get(level.name + "_cleared"):
				disabled = true
	

func _on_pressed() -> void:
	GameSettings.next_level = level_name
	GameSettings.change_scene(Paths.weapon_choice_screen)
