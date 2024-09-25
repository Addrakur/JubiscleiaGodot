class_name Wave
extends Node

@export var enemy_spawn: Array[WaveEnemySpawn]

var enemies: Array[CharacterBody2D]

var active: bool = false

@onready var arena_manager: ArenaManager = get_parent()

func spawn_enemies():
	for spawn in enemy_spawn:
		spawn.spawn_enemy()
	

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	for enemy in enemies:
		if enemy != null:
			return
	
	arena_manager.next_wave()
	active = false
	
