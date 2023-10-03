extends Node2D

@export var max_health: int
var current_health: int = 1
var alive: bool = true

func _ready() -> void:
	current_health = max_health

func update_health(value: float) -> void:
	current_health -= value

