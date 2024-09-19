extends Area2D

@onready var limit_area: CollisionPolygon2D = $LimitArea
@export var limit_polygon: Polygon2D
var enemy_list: Array
var enemy_kill_wall: Array[StaticBody2D]

var can_finish: bool = false

func _ready() -> void:
	var children = get_children()
	
	for child in children:
		if child.is_class("CharacterBody2D"):
			enemy_list.append(child)
		elif child.name == "Walls":
			var walls = child.get_children()
			for wall in walls:
				if wall.is_class("StaticBody2D"):
					enemy_kill_wall.append(wall)
	
	limit_area.polygon = limit_polygon.polygon
	
	can_finish = true

func on_body_entered(body):
	if body.is_in_group("player"):
		for enemy in enemy_list:
			enemy.player_on_limit = true
	
	if body.is_in_group("enemy"):
		enemy_list.append(body)
		body.parent = self

func on_body_exited(body):
	if body.is_in_group("player"):
		for enemy in enemy_list:
			enemy.player_on_limit = false
	
	if body.is_in_group("enemy"):
		erase(body)

func erase(enemy: CharacterBody2D):
	enemy_list.erase(enemy)

func add(enemy: CharacterBody2D):
	enemy_list.append(enemy)

func _process(_delta: float) -> void:
	if enemy_list.is_empty():
		for item in enemy_kill_wall:
			if item != null:
				item.queue_free()
