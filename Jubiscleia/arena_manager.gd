class_name ArenaManager
extends Node2D

@export var waves: Array[Wave]
@export var interval_time: float
@export var max_waves: float

@export_group("Objects")
@export var wall_manager: EnemyKillWallManager
@export var close_region: Area2D
@export var interval_label: Label

@onready var wave_interval: Timer = $WaveInterval

var current_wave: int = 1

func _ready() -> void:
	close_region.body_entered.connect(start_arena.bind())


func wave_start():
	var new_wave: Wave = waves[current_wave - 1] #Arrumar isso aqui, não sei o que está dando errado
	new_wave.spawn_enemies()
	new_wave.active = true
	

func next_wave():
	if current_wave == max_waves:
		arena_finish()
		return
	current_wave += 1
	wave_interval.start(interval_time)

func _on_wave_interval_timeout() -> void:
	wave_start()

func start_arena(body: CharacterBody2D):
	if not body.is_in_group("player"):
		return
	
	wall_manager.create_entrance_wall()
	wave_interval.start(interval_time)
	close_region.queue_free()

func _process(delta: float) -> void:
	if wave_interval.time_left != 0:
		interval_label.visible = true
		interval_label.text = str(int(wave_interval.time_left))
	else:
		interval_label.visible = false

func arena_finish():
	wall_manager.destroy_walls()
	interval_label.visible = false
