extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var spawn_point: Node2D = $SpawnPoint

@export var cooldown: float
@export var direction: float
var bee = preload("res://enemies/bee.tscn")
var can_shoot: bool = true

func _process(_delta):
	if can_shoot:
		shoot()

func shoot():
	var bee_inst = bee.instantiate()
	add_child(bee_inst)
	bee_inst.position = spawn_point.position
	bee_inst.direction = direction
	can_shoot = false
	timer.start(cooldown)

func on_timer_timeout():
	can_shoot = true
