extends CanvasLayer

@export var player: CharacterBody2D
@export var health_component: Node2D
@onready var hp_bar: TextureProgressBar = $PlayerUI/HP

func _ready() -> void:
	hp_bar.max_value = health_component.max_health
	hp_bar.value = health_component.current_health
	

func _process(_delta):
	hp_bar.value = health_component.current_health
	
