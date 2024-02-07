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

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var idle_state: State = $StateMachine/ScorpionIdle as ScorpionIdle
@onready var walk_state: State = $StateMachine/ScorpionWalk as ScorpionWalk
@onready var attack_state: State = $StateMachine/ScorpionAttack as ScorpionAttack

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

func left():
	texture.flip_h = false
	attack_area_collision.scale.x = 1
