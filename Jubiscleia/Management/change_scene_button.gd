extends Button

@export var scene_name: String

func _on_pressed() -> void:
	GameSettings.change_scene(Paths.get(scene_name))
