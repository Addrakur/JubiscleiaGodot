extends Node2D

var element: String
@onready var timer: Timer = $timer
@onready var texture: Sprite2D = $texture
@export var animation: AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameSettings.player.element_manager.rupture(element)
		queue_free()

func set_animation():
	animation.play(element)
