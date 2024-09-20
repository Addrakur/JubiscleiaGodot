class_name EnemyKillWallManager
extends Node2D

@export var enemies: Array[CharacterBody2D]
@export var wall_folder: Node2D
var walls: Array[StaticBody2D]

func _ready() -> void:
	var wall_temp = wall_folder.get_children()
	for child in wall_temp:
		walls.append(child)

func _process(_delta: float) -> void:
	
	for enemy in enemies:
		if enemy != null:
			return
	
	for wall in walls:
		if wall != null:
			wall.queue_free()
