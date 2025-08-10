extends Node

@onready var player: Player

var default_gravity: float = 10000

func _ready():
	Engine.max_fps = 60

func change_scene(scene_name:String):
	get_tree().change_scene_to_file.call_deferred(scene_name)
	get_tree().set_pause(false)

var arena_spawn_point: Vector2 = Vector2(-768,480)
var tutorial_spawn_point: Vector2 = Vector2(-389,421)
var tutorial_level_1_spawn_point: Vector2 = Vector2(320,0)
var tutorial_boss_level_spawn_point: Vector2 = Vector2(64,0)
var earth_level_1_spawn_point: Vector2 = Vector2(256,292)
var earth_level_2_spawn_point: Vector2 = Vector2(45,1733)
var level_3_spawn_point: Vector2 = Vector2(-68,37)

# Levels cleared

var tutorial_cleared: bool = true
var tutorial_level_1_cleared: bool = true
var tutorial_boss_cleared: bool = true

var earth_level_1_cleared: bool = true
var earth_level_2_cleared: bool = true
