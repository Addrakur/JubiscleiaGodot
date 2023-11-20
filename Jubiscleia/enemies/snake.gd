extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D

@onready var texture: Sprite2D = $Texture
@onready var collision_2: CollisionShape2D = $Collision2
const C_2_POSITION: float = -13
@onready var attack_area_collision: CollisionShape2D = $AttackArea/AttackCollision
const AAC_POSITION: float = -33
@onready var can_attack_area_1: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -33
@onready var can_attack_area_2: CollisionShape2D = $CanAttackArea/CanAttackCollision2
const CAA_POSITION_2: float = 29
@onready var attack_timer: Timer = $AttackTimer

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var move_state: State = $StateMachine/SnakeMove as SnakeMove
@onready var attack_state: State = $StateMachine/SnakeAttack as SnakeAttack
@onready var hit_state: State = $StateMachine/SnakeHit as SnakeHit
@onready var idle_state: State = $StateMachine/SnakeIdle as SnakeIdle
@onready var death_state: State = $StateMachine/SnakeDeath as SnakeDeath
@onready var fall_state: State = $StateMachine/SnakeFall as SnakeFall
@onready var chase_state: State = $StateMachine/SnakeChase as SnakeChase

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false

var is_attacking: bool = false

var alive: bool = true

@export var direction: float

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(_delta):
	if !health_component.is_getting_hit:
		if velocity.x < 0:
			left()
		elif velocity.x > 0:
			right()

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = gravity * delta

func right():
	texture.flip_h = true
	attack_area_collision.position.x = -AAC_POSITION
	can_attack_area_1.position.x = -CAA_POSITION
	can_attack_area_2.position.x = -CAA_POSITION_2
	collision_2.position.x = -C_2_POSITION

func left():
	texture.flip_h = false
	attack_area_collision.position.x = AAC_POSITION
	can_attack_area_1.position.x = CAA_POSITION
	can_attack_area_2.position.x = CAA_POSITION_2
	collision_2.position.x = C_2_POSITION
