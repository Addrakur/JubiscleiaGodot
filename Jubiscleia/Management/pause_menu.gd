extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu

func _process(_delta):
	if get_tree().is_paused():
		pause_menu.show()
	else:
		pause_menu.hide()

func on_resume_pressed():
	get_tree().paused = false

func on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene.call_deferred()
	#get_tree().paused = false
