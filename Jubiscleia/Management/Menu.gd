extends Control

@onready var skill_tree: Control = $skill_tree

func _ready() -> void:
	pass

func on_quit_pressed():
	get_tree().quit()

func _on_skill_tree_button_pressed() -> void:
	if skill_tree.visible:
		skill_tree.visible = false
	else:
		skill_tree.visible = true
