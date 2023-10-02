extends Area2D

@onready var level: Node2D = get_parent().get_parent()
@onready var collision_polygon: CollisionPolygon2D = $Collision
@onready var polygon: Polygon2D = $Area

@export var limits: Array

func _ready() -> void:
	collision_polygon.polygon = polygon.polygon

func on_player_entered(body):
	if body.is_in_group("player"):
		level.change_limit(limits[0],limits[1],limits[2],limits[3])
