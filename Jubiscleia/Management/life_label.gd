extends Label

@export var parent: Node2D
@onready var progress_bar = $ProgressBar

func _ready():
	progress_bar.max_value = parent.health_component.max_health if not parent.health_component.has_parameter_slider else parent.health_component.true_max_health

func _process(_delta):
	text = str(parent.health_component.current_health if parent.health_component.current_health > 0 else 0)
	progress_bar.value = parent.health_component.current_health
	
