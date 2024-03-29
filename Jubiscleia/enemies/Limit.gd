extends Area2D

@onready var limit_area: CollisionPolygon2D = $LimitArea
@export var limit_polygon: Polygon2D
var enemy_list: Array

func _ready() -> void:
	var children = get_children()
	
	for child in children:
		if child.is_class("CharacterBody2D"):
			enemy_list.append(child)
	
	limit_area.polygon = limit_polygon.polygon

func on_body_entered(body):
	if body.is_in_group("player"):
		for enemy in enemy_list:
			enemy.player_on_limit = true

func on_body_exited(body):
	if body.is_in_group("player"):
		for enemy in enemy_list:
			enemy.player_on_limit = false

func erase(enemy: CharacterBody2D):
	enemy_list.erase(enemy)
