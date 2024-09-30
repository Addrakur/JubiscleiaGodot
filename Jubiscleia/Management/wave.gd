class_name Wave
extends Node

var enemy_spawn: Array

var enemies: Array[CharacterBody2D]

var active: bool = false

@onready var arena_manager: ArenaManager = get_parent()

func _ready() -> void:
	enemy_spawn = get_children()

func spawn_enemies():
	for spawn in enemy_spawn:
		spawn.spawn_enemy()
	

func _physics_process(_delta: float) -> void:
	if not active:
		return
	
	for enemy in enemies:
		if enemy != null:
			return
	
	arena_manager.next_wave()
	active = false
	
