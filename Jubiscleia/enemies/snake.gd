extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D

@onready var collision: CollisionShape2D = $Collision
const COLLISION_POSITION: float = -6
@onready var texture: Sprite2D = $Texture
@onready var attack_area_collision: CollisionShape2D = $AttackArea/AttackCollision
const AAC_POSITION: float = -33
@onready var can_attack_area_1: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -33
@onready var can_attack_area_2: CollisionShape2D = $CanAttackArea/CanAttackCollision2
const CAA_POSITION_2: float = 16

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var move_state: State = $StateMachine/SnakeMove as SnakeMove
@onready var attack_state: State = $StateMachine/SnakeAttack as SnakeAttack
@onready var hit_state: State = $StateMachine/SnakeHit as SnakeHit
@onready var idle_state: State = $StateMachine/SnakeIdle as SnakeIdle
@onready var death_state: State = $StateMachine/SnakeDeath as SnakeDeath

@onready var player_ref: CharacterBody2D

var is_attacking: bool = false

var alive: bool = true

var direction: float

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	var dir_chance: float = randf_range(-50,50)
	if dir_chance < 0:
		direction = -1
	else:
		direction = 1

func _process(_delta):
	flip()
	if !alive:
		health_component.die()

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = gravity
	

func flip() -> void:
	if velocity.x < 0:
		texture.flip_h = false
		attack_area_collision.position.x = AAC_POSITION
		can_attack_area_1.position.x = CAA_POSITION
		can_attack_area_2.position.x = CAA_POSITION_2
		collision.position.x = COLLISION_POSITION
		
	elif velocity.x > 0:
		texture.flip_h = true
		attack_area_collision.position.x = -AAC_POSITION
		can_attack_area_1.position.x = -CAA_POSITION
		can_attack_area_2.position.x = -CAA_POSITION_2
		collision.position.x = -COLLISION_POSITION
		
