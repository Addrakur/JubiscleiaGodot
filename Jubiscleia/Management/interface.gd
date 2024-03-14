extends CanvasLayer

@export var player: CharacterBody2D
@export var health_component: Node2D
@onready var hp_bar: TextureProgressBar = $PlayerUI/HP
@onready var corruption_control: Label =  $PlayerUI/CorruptionControl
@onready var hit_counter: Label = $PlayerUI/HitCounter

func _ready() -> void:
	hp_bar.max_value = health_component.max_health
	hp_bar.value = health_component.current_health

func _process(_delta):
	hp_bar.value = health_component.current_health
	
	corruption_control.text = "Corruption: " + str(PlayerVariables.corruption_level)
	hit_counter.text = "Hit: " + str(PlayerVariables.hit_amount)
