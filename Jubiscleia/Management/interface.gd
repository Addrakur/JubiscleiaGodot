extends CanvasLayer

@export var game: Node
@export var player: CharacterBody2D
@export var level: Node2D
@onready var pause_menu: Control = $PauseMenu
@onready var health_component: Node2D = player.health_component
@onready var hp_bar: TextureProgressBar = $PlayerUI/HP

func _ready() -> void:
	hp_bar.max_value = health_component.max_health
	hp_bar.value = health_component.current_health

func _process(_delta):
	hp_bar.value = health_component.current_health
	if get_tree().paused:
		pause_menu.show()
	else:
		pause_menu.hide()

func on_resume_pressed():
	get_tree().paused = false

func on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
