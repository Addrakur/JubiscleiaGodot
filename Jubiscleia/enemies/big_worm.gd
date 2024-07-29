extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float
@export var gravity_mult: float

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionPolygon2D = $Collision
@onready var attack_area_collision: CollisionPolygon2D = $AttackArea/AttackCollision
@onready var can_attack_area: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -5
@onready var attack_timer: Timer = $AttackTimer

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var move_state: State = $StateMachine/BigWormMove as BigWormMove
@onready var idle_state: State = $StateMachine/BigWormIdle as BigWormIdle
@onready var attack_state: State = $StateMachine/BigWormAttack as BigWormAttack
@onready var hit_state: State = $StateMachine/BigWormHit as BigWormHit
@onready var death_state: State = $StateMachine/BigWormDeath as BigWormDeath
@onready var state = $StateMachine/State as State

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	attack_area.attack_name = name + "_attack"

func _process(_delta):
	if alive and not health_component.is_getting_hit:
		if fsm.state == move_state:
			if velocity.x < 0:
				left()
			elif velocity.x > 0:
				right()
		
		if not PlayerVariables.player_alive:
			player_ref = null
	
	if not alive and not fsm.state == death_state:
		fsm.change_state(death_state)
	elif health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)
	

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = gravity * delta * gravity_mult
	

func can_attack_area_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = body

func can_attack_area_exited(body):
	if body == player_ref:
		player_ref = null

func right():
	texture.flip_h = true
	collision.scale.x = -1
	attack_area_collision.scale.x = -1
	can_attack_area.position.x = -CAA_POSITION

func left():
	texture.flip_h = false
	collision.scale.x = 1
	attack_area_collision.scale.x = 1
	can_attack_area.position.x = CAA_POSITION
