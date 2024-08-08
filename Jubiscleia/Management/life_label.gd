extends Label

@export var parent: Node2D
@onready var progress_bar = $ProgressBar

func _ready():
	progress_bar.max_value = parent.health_component.max_health

func _process(_delta):
	text = str(parent.health_component.current_health)
	progress_bar.value = parent.health_component.current_health
	
