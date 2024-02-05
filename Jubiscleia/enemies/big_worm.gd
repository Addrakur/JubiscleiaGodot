extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float
@export var gravity_mult: float

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionShape2D = $Collision
const C_POSITION: float = -1
@onready var attack_area_collision: CollisionPolygon2D = $AttackArea/AttackCollision
@onready var can_attack_area: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -5
@onready var attack_timer: Timer = $AttackTimer

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var move_state: State = $StateMachine/BigWormMove as BigWormMove
@onready var idle_state: State = $StateMachine/BigWormIdle as BigWormIdle
@onready var attack_state: State = $StateMachine/BigWormAttack as BigWormAttack

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if fsm.state == move_state:
		if velocity.x < 0:
			left()
		elif velocity.x > 0:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = gravity * delta * gravity_mult

func right():
	texture.flip_h = true
	collision.position.x = -C_POSITION
	attack_area_collision.scale.x = -1
	can_attack_area.position.x = -CAA_POSITION

func left():
	texture.flip_h = false
	collision.position.x = C_POSITION
	attack_area_collision.scale.x = 1
	can_attack_area.position.x = CAA_POSITION
