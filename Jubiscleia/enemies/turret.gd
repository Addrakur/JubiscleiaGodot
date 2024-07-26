extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var spawn_point: Node2D = $SpawnPoint
@onready var texture = $Texture

@export var cooldown: float
@export var direction: float
var can_shoot: bool = true

func _ready():
	if direction == 1:
		texture.flip_h = true
	
	spawn_point.position.x *= -direction

func _process(_delta):
	if can_shoot:
		shoot()

func shoot():
	var bee_inst = Paths.bee.instantiate()
	add_child(bee_inst)
	bee_inst.position = spawn_point.position
	bee_inst.direction = direction
	bee_inst.texture.flip_h = true if direction == 1 else false
	can_shoot = false
	timer.start(cooldown)

func on_timer_timeout():
	can_shoot = true
