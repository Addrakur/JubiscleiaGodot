extends Label

@export var parent: Node2D

func _process(delta):
	text = str(parent.health_component.current_health)
