extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float
@export var starting_x: Marker2D

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionPolygon2D = $Collision
@onready var run_collision = $RunArea/RunCollision
@onready var cant_run_timer = $CantRunTimer
@onready var wall_sensor = $WallSensor

@onready var fsm = $StateMachine as StateMachine
@onready var state = $StateMachine/State as State
@onready var idle_state = $StateMachine/KitsuneIdle as KitsuneIdle
@onready var walk_state = $StateMachine/KitsuneWalk as KitsuneWalk
@onready var run_state = $StateMachine/KitsuneRun as KitsuneRun

@onready var player_ref: CharacterBody2D
var player_on_limit: bool = false
var player_on_run_area: bool = false
var is_attacking: bool = false

var alive: bool = true 

var gravity: float
var gravity_mult: float = 4

func _ready():
	gravity = GameSettings.default_gravity
	

func _process(_delta):
	if not health_component.is_getting_hit and alive:
		if direction == -1:
			left()
		elif direction == 1:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
#	if not alive:
#		fsm.change_state(death_state)
#
#	if health_component.is_getting_hit and not fsm.state == hit_state:
#		fsm.change_state(hit_state)
	

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = false
	collision.scale.x = 1
	run_collision.scale.x = 1
	wall_sensor.scale.x = 1

func left():
	texture.flip_h = true
	collision.scale.x = -1
	run_collision.scale.x = -1
	wall_sensor.scale.x = -1

func _on_run_area_body_entered(body):
	if body == player_ref:
		player_on_run_area = true

func _on_run_area_body_exited(body):
	if body == player_ref:
		player_on_run_area = false

func _on_detect_area_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = body

func _on_detect_area_body_exited(body):
	if body == player_ref:
		player_ref = null
