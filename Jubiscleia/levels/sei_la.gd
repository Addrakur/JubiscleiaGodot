extends Node2D

@export var player: Player

func _ready() -> void:
	player.element_manager.active = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player.element_manager.active = true
