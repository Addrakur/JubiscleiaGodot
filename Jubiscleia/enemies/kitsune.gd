extends CharacterBody2D

@export var health_component: Node2D
@export var off_set_wander: float
@export var min_wander: float
@export var starting_x: Marker2D
@export var warp_area: Polygon2D

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionPolygon2D = $Collision
@onready var run_collision = $RunArea/RunCollision
@onready var short_collision = $CanAttackShort/ShortCollision
@onready var cant_run_timer = $CantRunTimer
@onready var attack_timer = $AttackTimer
@onready var wall_sensor = $WallSensor
@onready var trapped_sensor = $TrappedSensor
@onready var attack_spawn_point = $AttackSpawnPoint
@onready var hit_modulate = $HitModulate
@onready var poise_timer = $PoiseTimer

#const ASP_POSITION: float = 47

@onready var fsm = $StateMachine as StateMachine
@onready var state = $StateMachine/State as State
@onready var idle_state = $StateMachine/KitsuneIdle as KitsuneIdle
@onready var walk_state = $StateMachine/KitsuneWalk as KitsuneWalk
@onready var run_state = $StateMachine/KitsuneRun as KitsuneRun
@onready var death_state = $StateMachine/KitsuneDeath as KitsuneDeath
@onready var hit_state = $StateMachine/KitsuneHit as KitsuneHit
@onready var attack_state = $StateMachine/KitsuneAttack as KitsuneAttack
@onready var warp_state = $StateMachine/KitsuneWarp

@onready var player_ref: CharacterBody2D
var player_on_limit: bool = false
var player_on_run_area: bool = false
var can_attack_short_range: bool = false
var can_attack_player: bool = false
var is_attacking: bool = false

var alive: bool = true 

var direction: float
var gravity: float
var gravity_mult: float = 0.18


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
	
	if not alive and not fsm.state == death_state:
		fsm.change_state(death_state)
	elif health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)
	
	

func _physics_process(_delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * gravity_mult

func right():
	texture.flip_h = false
	collision.scale.x = 1
	run_collision.scale.x = 1
	short_collision.scale.x = 1
	wall_sensor.scale.x = 1
	trapped_sensor.scale.x = 1
	#attack_spawn_point.position.x = ASP_POSITION

func left():
	texture.flip_h = true
	collision.scale.x = -1
	run_collision.scale.x = -1
	short_collision.scale.x = -1
	wall_sensor.scale.x = -1
	trapped_sensor.scale.x = -1
	#attack_spawn_point.position.x = -ASP_POSITION

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

func _on_can_attack_short_body_entered(body):
	if body == player_ref:
		can_attack_short_range = true

func _on_can_attack_short_body_exited(body):
	if body == player_ref:
		can_attack_short_range = false

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.max_poise
