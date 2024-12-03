extends Node2D

@onready var turret: StaticBody2D = get_parent()
@export var speed: float
var direction: float
var can_destroy: bool = false
@onready var texture = $Texture
@onready var attack_area: AttackArea = $AttackArea

func _process(delta):
	position.x += direction * speed * delta
	
	if can_destroy:
		queue_free()
