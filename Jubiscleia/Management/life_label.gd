extends TextureProgressBar

@export var parent: Node2D

func _ready():
	max_value = parent.health_component.max_health if not parent.health_component.has_parameter_slider else parent.health_component.true_max_health

func _process(_delta):
	value = parent.health_component.current_health
	
	if value == max_value:
		visible = false
	else:
		visible = true
