extends Node2D

var element: String = "water"
@onready var timer: Timer = $timer
@onready var texture: Sprite2D = $texture
@onready var animation: AnimationPlayer = $animation

func _ready() -> void:
	animation.play(element)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		PlayerVariables.water_stack_count = body.element_manager.max_element_stack
		queue_free()
