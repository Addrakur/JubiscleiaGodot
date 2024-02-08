extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float
@export var gravity_mult: float
@export var starting_x: float

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionShape2D = $Collision
@onready var attack_area_collision: CollisionPolygon2D = $AttackArea/AttackPolygon
@onready var can_attack_area_collision: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -53
@onready var raycast: RayCast2D = $WallRaycast
@onready var attack_timer: Timer = $AttackTimer

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var idle_state: State = $StateMachine/ScorpionIdle as ScorpionIdle
@onready var walk_state: State = $StateMachine/ScorpionWalk as ScorpionWalk
@onready var attack_state: State = $StateMachine/ScorpionAttack as ScorpionAttack
@onready var hit_state: State = $StateMachine/ScorpionHit as ScorpionHit
@onready var death_state: State = $StateMachine/ScorpionDeath as ScorpionDeath

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(_delta):
	if fsm.state == walk_state or fsm.state == attack_state:
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
