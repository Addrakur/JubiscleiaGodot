extends TextureProgressBar

@export var parent: Node2D

func _ready():
	max_value = parent.health_component.max_temp_life
	parent.health_component.current_temp_life = parent.health_component.starting_temp_life

func _process(_delta):
	value = parent.health_component.current_temp_life

	if value > 0:
		visible = true
	else:
		visible = false
