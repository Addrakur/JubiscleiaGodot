extends CanvasLayer

@onready var life_bar: TextureProgressBar = $Control/HP
@onready var player: CharacterBody2D = get_parent()

@export var max_life: float
@export var life: float

func _ready() -> void:
	life_bar.max_value = max_life
	life_bar.value = life

func _process(_delta):
	pass

func update_life(damage) -> void:
	life -=damage
	life_bar.value = life
