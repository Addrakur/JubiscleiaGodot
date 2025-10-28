extends Node

@onready var player: Player

var default_gravity: float = 10000

var next_level: String

func _ready():
	Engine.max_fps = 60

func change_scene(scene_name:String):
	get_tree().change_scene_to_file.call_deferred(scene_name)
	get_tree().set_pause(false)

var arena_spawn_point: Vector2 = Vector2(-768,480)
var tutorial_spawn_point: Vector2 = Vector2(64,416)
var tutorial_2_spawn_point: Vector2 = Vector2(288,288)
var tutorial_boss_level_spawn_point: Vector2 = Vector2(64,0)
var level_1_spawn_point: Vector2 = Vector2(320,0)
var level_2_spawn_point: Vector2 = Vector2(45,1733)
var level_3_spawn_point: Vector2 = Vector2(64,0)
var level_4_spawn_point: Vector2 = Vector2(192,-763)

# Levels cleared

var tutorial_cleared: bool = true
var tutorial_2_cleared: bool = true
var tutorial_boss_cleared: bool = true

var level_1_cleared: bool = true
var level_2_cleared: bool = true
var level_3_cleared: bool = true
var level_4_cleared: bool = true
