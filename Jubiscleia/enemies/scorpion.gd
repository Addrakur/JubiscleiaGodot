class_name Scorpion
extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: AttackArea
@export var direction: float
@export var starting_x: Marker2D
@export_enum("water","fire","earth","air") var element: String

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionShape2D = $Collision
@onready var attack_area_collision: CollisionPolygon2D = $AttackArea/AttackPolygon
@onready var can_attack_area_collision: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -53
@onready var raycast: RayCast2D = $WallRaycast
@onready var attack_timer: Timer = $AttackTimer
@onready var poise_timer: Timer = $PoiseTimer
@onready var hit_modulate: AnimationPlayer = $HitModulate

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var idle_state: State = $StateMachine/ScorpionIdle as ScorpionIdle
@onready var walk_state: State = $StateMachine/ScorpionWalk as ScorpionWalk
@onready var attack_state: State = $StateMachine/ScorpionAttack as ScorpionAttack
@onready var hit_state: State = $StateMachine/ScorpionHit as ScorpionHit
@onready var death_state: State = $StateMachine/ScorpionDeath as ScorpionDeath
@onready var state = $StateMachine/State as State

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

var speed: float = 1

func _ready():
	attack_area.attack_name = name + "hit"
	

func _process(_delta):
	if fsm.state == walk_state or fsm.state == attack_state:
		if velocity.x < 0:
			left()
		elif velocity.x > 0:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	if not alive:
		fsm.change_state(death_state)

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = true
	attack_area_collision.scale.x = -1
	raycast.scale.x = -1
	can_attack_area_collision.position.x = -CAA_POSITION

func left():
	texture.flip_h = false
	attack_area_collision.scale.x = 1
	raycast.scale.x = 1
	can_attack_area_collision.position.x = CAA_POSITION

func can_attack_area_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func can_attack_area_exited(body):
	if body.is_in_group("player"):
		player_ref = null

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.max_poise
