extends Node2D

@onready var turret: StaticBody2D = get_parent()
@export var speed: float
var direction: float

func _process(delta):
	position.x += direction * speed * delta
