class_name SniperEnemy
extends CharacterBody2D

@export var health_component: Node2D
var direction: float

@onready var limit: Area2D = get_parent()
@onready var body_texture: Sprite2D = $body_texture
@onready var arm_texture: Sprite2D = $arm_texture

@onready var hsm: LimboHSM = $HSM
@onready var idle_state: SniperEnemyIdle = $HSM/SniperEnemyIdle

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

func _ready() -> void:
	init_state_machine()

func _physics_process(delta: float) -> void:
	set_direction()
	flip_body()

func init_state_machine():
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func set_direction():
	if $laser.points[1].x > 0:
		direction = 1
	else:
		direction = -1

func flip_body():
	if direction == 1:
		body_texture.flip_h = true
	else:
		body_texture.flip_h = false
