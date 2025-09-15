extends Node2D

@onready var turret: StaticBody2D = get_parent()
@export var speed: float
@export var top_size_y: float
@export var bot_size_y: float
@export var left_size_x: float
@export var right_size_x: float
var direction: float
var can_destroy: bool = false
@onready var texture = $Texture

func _process(delta):
	position.x += direction * speed * delta
	
	if can_destroy:
		queue_free()
