extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionPolygon2D = $SkeletonCollision
@onready var chase_area: CollisionPolygon2D = $CanChaseArea/CanChaseArea
@onready var can_attack_ground: CollisionPolygon2D = $CanAttackGround/CanAttackGroundArea
@onready var can_attack_air: CollisionPolygon2D = $CanAttackAir/CanAttackAirArea
@onready var attack_area_ground: CollisionPolygon2D = $AttackArea/AttackCollisionGround
@onready var attack_area_air: CollisionPolygon2D = $AttackArea/AttackCollisionAir

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var walk_state: State = $StateMachine/SpearSkeletonWalk as SpearSkeletonWalk
@onready var idle_state: State = $StateMachine/SpearSkeletonIdle as SpearSkeletonIdle
@onready var run_state: State = $StateMachine/SpearSkeletonRun as SpearSkeletonRun
@onready var attack_state: State = $StateMachine/SpearSkeletonAttack as SpearSkeletonAttack
@onready var hit_state: State = $StateMachine/SpearSkeletonHit as SpearSkeletonHit
@onready var death_state: State = $StateMachine/SpearSkeletonDeath as SpearSkeletonDeath
@onready var state = $StateMachine/State as State

@onready var player_ref: CharacterBody2D
var can_attack_player_air: bool = false
var can_attack_player_ground: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true 

var gravity: float
var gravity_mult: float = 4


func _ready():
	attack_area.attack_name = name + "hit"

func _process(_delta):
	if not health_component.is_getting_hit and alive:
		if direction == -1:
			left()
		elif direction == 1:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	if not alive:
		fsm.change_state(death_state)
	
	if health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)
	

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = false
	collision.scale.x = 1
	chase_area.scale.x = 1
	can_attack_ground.scale.x = 1
	can_attack_air.scale.x = 1
	attack_area_ground.scale.x = 1
	attack_area_air.scale.x = 1

func left():
	texture.flip_h = true
	collision.scale.x = -1
	chase_area.scale.x = -1
	can_attack_ground.scale.x = -1
	can_attack_air.scale.x = -1
	attack_area_ground.scale.x = -1
	attack_area_air.scale.x = -1

func can_chase_area_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = body

func can_chase_area_body_exited(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = null

func can_attack_ground_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		can_attack_player_ground = true

func can_attack_ground_body_exited(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		can_attack_player_ground = false

func can_attack_air_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		can_attack_player_air = true

func can_attack_air_body_exited(body):
	if body.is_in_group("player") and not body.is_in_group("projetile"):
		can_attack_player_air = false
