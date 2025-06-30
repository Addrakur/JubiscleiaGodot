extends Node

@onready var player: Player

var default_gravity: float

func _ready():
	Engine.max_fps = 60

func _input(event):
	if event.is_action_pressed("pause") or not PlayerVariables.player_alive:
		var current_value: bool = get_tree().paused
		get_tree().paused = !current_value

func change_scene(scene_name:String):
	get_tree().set_pause(false)
	get_tree().change_scene_to_file.call_deferred(scene_name)

var arena_spawn_point: Vector2 = Vector2(-768,480)
var tutorial_spawn_point: Vector2 = Vector2(-389,421)
var tutorial_level_1_spawn_point: Vector2 = Vector2(320,0)
var tutorial_boss_level_spawn_point: Vector2 = Vector2(64,0)
var level_1_spawn_point: Vector2 = Vector2(-5434,1637)
var level_2_spawn_point: Vector2 = Vector2(45,1733)
var level_3_spawn_point: Vector2 = Vector2(-68,37)

# Levels cleared

var tutorial_cleared: bool = false
var tutorial_level_1_cleared: bool = false
var tutorial_boss_level_cleared: bool = false
