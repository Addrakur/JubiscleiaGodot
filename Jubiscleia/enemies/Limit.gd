class_name EnemyLimit
extends Area2D

@onready var limit_area: CollisionPolygon2D = $LimitArea
@export var limit_polygon: Polygon2D
@export var arena_limit: bool
var enemy_list: Array

var can_finish: bool = false

var player_inside_limit: bool = false

func _ready() -> void:
	var children = get_children()
	
	for child in children:
		if child.is_class("CharacterBody2D"):
			enemy_list.append(child)
	
	limit_area.polygon = limit_polygon.polygon
	
	can_finish = true

func on_body_entered(body):
	if body is Player:
		player_inside_limit = true
		for enemy in enemy_list:
			enemy.player_on_limit = true
	
	if body.is_in_group("enemy"):
		enemy_list.append(body)
		body.parent = self

func on_body_exited(body):
	if body.is_in_group("player"):
		player_inside_limit = false
		for enemy in enemy_list:
			if enemy != null:
				enemy.player_on_limit = false
	
	if body.is_in_group("enemy"):
		erase(body)

func erase(enemy: CharacterBody2D):
	enemy_list.erase(enemy)

func add(enemy: CharacterBody2D):
	enemy_list.append(enemy)
