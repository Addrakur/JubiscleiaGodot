extends CanvasLayer

@export var game: Node
@onready var pause_menu: Control = $PauseMenu

func _process(_delta):
	if get_tree().paused:
		pause_menu.show()
	else:
		pause_menu.hide()

func on_resume_pressed():
	get_tree().paused = false

func on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
