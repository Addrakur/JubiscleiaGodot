class_name LightningDash
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_area: EnemyAttackArea
@export_enum("water","fire","earth","air") var element: String
@export var top_size_y: float
@export var bot_size_y: float
@export var left_size_x: float
@export var right_size_x: float

@export var starting_x: Marker2D
@export var max_wandering_distance: float

@onready var limit: EnemyLimit = get_parent()
@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision
@onready var hit_modulate: AnimationPlayer = $hit_modulate
@onready var is_on_wall_raycast: RayCast2D = $is_on_wall
@onready var can_attack_player_collision: CollisionPolygon2D = $can_attack_player/can_attack_player_collision

@onready var hsm: LimboHSM = $hsm
@onready var walk_state: LimboState = $hsm/lightning_dash_walk
@onready var attack_state: LimboState = $hsm/lightning_dash_attack
@onready var stun_state: LimboState = $hsm/lightning_dash_stun
@onready var death_state: LimboState = $hsm/lightning_dash_death

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false

var alive: bool = true 

var speed: float = 1
var direction: float

var can_destroy: bool = false

func _ready() -> void:
	init_state_machine()

func _process(_delta: float) -> void:
	if not alive:
		hsm.dispatch("die")
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta
	move_and_slide()

func left():
	texture.flip_h = false
	is_on_wall_raycast.scale.x = 1
	can_attack_player_collision.scale.x = 1

func right():
	texture.flip_h = true
	is_on_wall_raycast.scale.x = -1
	can_attack_player_collision.scale.x = -1

func init_state_machine():
	hsm.add_transition(walk_state, attack_state, &"walk_to_attack")
	
	hsm.add_transition(attack_state, stun_state, &"attack_to_stun")
	
	hsm.add_transition(stun_state, walk_state, &"stun_to_walk")
	
	hsm.add_transition(hsm.ANYSTATE, death_state, &"die")
	
	hsm.initial_state = walk_state
	hsm.initialize(self)
	hsm.set_active(true)

func _on_can_attack_player_body_entered(body: Node2D) -> void:
	if body is Player:
		can_attack_player = true
		player_ref = body

func _on_can_attack_player_body_exited(body: Node2D) -> void:
	if body is Player:
		can_attack_player = false

func turn():
	if velocity.x < 0:
		left()
	elif velocity.x > 0:
		right()

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""
