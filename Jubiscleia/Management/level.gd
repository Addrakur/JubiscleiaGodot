extends Node2D

@onready var player: CharacterBody2D = $player
#@export var tween_time: float

func _ready() -> void:
	change_limit(0,0,2688,704)

func change_limit(limit_top: int, limit_left: int, limit_right: int, limit_bottom: int) -> void:
	#var tween = create_tween().set_parallel(true)
	#tween.tween_property(player.camera,"limit_left",limit_left,tween_time)
	#tween.tween_property(player.camera,"limit_bottom",limit_bottom,tween_time)
	#tween.tween_property(player.camera,"limit_top",limit_top,tween_time)
	#tween.tween_property(player.camera,"limit_right",limit_right,tween_time)
	player.camera.limit_top = limit_top
	player.camera.limit_left = limit_left
	player.camera.limit_right = limit_right
	player.camera.limit_bottom = limit_bottom

func restart() -> void:
	get_tree().reload_current_scene()
