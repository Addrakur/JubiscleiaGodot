extends Node2D

var element: String
@onready var timer: Timer = $timer
@onready var texture: Sprite2D = $texture
@export var animation: AnimationPlayer


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and PlayerVariables.elemental_rupture == "":
		PlayerVariables.set(element + "_stack_count", body.element_manager.max_element_stack)
		queue_free()

func set_animation():
	animation.play(element)
