extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float
@export var y: float
@export var hover_offset: float

@onready var limit: Area2D = get_parent()
@onready var attack_timer: Timer = $AttackTimer
@onready var texture: Sprite2D = $Texture
@onready var detect_area: Area2D = $DetectArea

@onready var fly_state: State = $StateMachine/VultureFly as VultureFly
@onready var hover_state: State = $StateMachine/VultureHover as VultureHover
@onready var attack_state: State = $StateMachine/VultureAttack as VultureAttack
@onready var death_state: State = $StateMachine/VultureDeath as VultureDeath
var hit_state: State = null

@onready var fsm: StateMachine = $StateMachine as StateMachine

@onready var player_ref: CharacterBody2D

var alive: bool = true
var hover: bool = false
var is_attacking: bool = false
var player_on_limit: bool = false

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

const IDLE_OFFSET: float = -16

func _ready():
	pass

func _process(_delta):
	if not health_component.is_getting_hit and not hover:
		if velocity.x < 0:
			left()
		elif velocity.x > 0:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	if not alive and not fsm.state == death_state:
		fsm.change_state(death_state)

func _physics_process(_delta):
	move_and_slide()
	if not hover and not is_attacking:
		position.y = y

func right():
	texture.flip_h = true

func left():
	texture.flip_h = false
