class_name EnemyKillWallManager
extends Node2D

@export var exit_walls: Node2D
@export var entrance_walls: Node2D

var all_entrance_walls: Array
var all_exit_walls: Array

func _ready() -> void:
	all_entrance_walls = entrance_walls.get_children()
	all_exit_walls = exit_walls.get_children()
	for wall in all_entrance_walls:
		wall.set_collision_layer_value(17,false)
	entrance_walls.visible = false

func destroy_walls():
	for wall in all_exit_walls:
		if wall != null:
			wall.queue_free()
	
	for wall in all_entrance_walls:
		if wall != null:
			wall.queue_free()

func create_entrance_wall():
	entrance_walls.visible = true
	for wall in all_entrance_walls:
		wall.set_collision_layer_value(17,true)
