extends CanvasLayer

@export var player: CharacterBody2D
@export var health_component: Node2D
@onready var hp_bar: TextureProgressBar = $Control/HP
@onready var restart_button: Button = $Control/Restart
@onready var level: Node2D = get_parent().get_parent()

func _ready() -> void:
	hp_bar.max_value = health_component.max_health
	hp_bar.value = health_component.current_health

func _process(_delta):
	hp_bar.value = health_component.current_health

func _on_restart_pressed():
	level.restart()
