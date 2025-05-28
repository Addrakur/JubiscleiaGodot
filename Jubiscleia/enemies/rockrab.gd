class_name Rockrab
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_area: AttackArea
@export_enum("water","fire","earth","air") var element: String

@onready var limit: EnemyLimit = get_parent()
@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/rockrab_idle
@onready var walk_state: LimboState = $hsm/rockrab_walk

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false

var alive: bool = true 

var speed: float = 1
var direction: float

func _ready() -> void:
	init_state_machine()

func _process(_delta):
	if alive and not health_component.is_getting_hit:
		if hsm.get_active_state() == walk_state:
			if velocity.x < 0:
				left()
			elif velocity.x > 0:
				right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	

func left():
	texture.flip_h = false

func right():
	texture.flip_h = true

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta

func init_state_machine():
	hsm.add_transition(idle_state, walk_state, "idle_to_walk")
	
	hsm.add_transition(walk_state, idle_state, "walk_to_idle")
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)
