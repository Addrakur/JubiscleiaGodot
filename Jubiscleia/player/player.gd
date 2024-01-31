class_name Player
extends CharacterBody2D

@export var attack_area: Area2D
@export var health_component: Node2D

@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var camera: Camera2D = $Camera
@onready var attack_area_polygon: CollisionPolygon2D = $AttackArea/AttackArea
const ATTACK_AREA_POSITION: float = 39

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var idle_state: State = $StateMachine/Idle as PlayerIdle
@onready var move_state: State = $StateMachine/Move as PlayerMove
@onready var crouch_state: State = $StateMachine/Crouch as PlayerCrouch
@onready var jump_state: State = $StateMachine/Jump as PlayerJump
@onready var double_jump_state: State = $StateMachine/DoubleJump as PlayerDoubleJump
@onready var fall_state: State = $StateMachine/Fall as PlayerFall
@onready var hit_state: State = $StateMachine/Hit as PlayerHit
@onready var death_state: State = $StateMachine/Death as PlayerDeath
@onready var attack_1_state: State = $StateMachine/PlayerAttack1 as PlayerAttack1
@onready var attack_2_state: State = $StateMachine/PlayerAttack2 as PlayerAttack2
@onready var attack_3_state: State = $StateMachine/PlayerAttack3 as PlayerAttack3
@onready var jump_attack_state: State = $StateMachine/PlayerJumpAttack as PlayerJumpAttack

@export_group("Jump Variables")
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var max_jump_count: float
var jump_count: float = 0
var jump_velocity: float
var jump_gravity: float
var fall_gravity: float
var override_gravity: float = 0

var alive: bool = true
var can_combo: bool
var my_knockup: bool = false

var direction: float
var last_direction: float = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	PlayerVariables.player_alive = true
	
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1
	fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1
	
func _process(_delta):
	if not health_component.is_getting_hit:
		flip()

func _physics_process(delta):
	if not is_on_floor():
		get_gravity()
		velocity.y += gravity * delta
	if alive:
		move_and_slide()
	
	if direction != 0:
		last_direction = direction
	

func get_gravity():
	if override_gravity == 0:
		if velocity.y < 0:
			gravity = jump_gravity
		else:
			gravity = fall_gravity
	else:
		gravity = override_gravity
	

func flip() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_polygon.position.x = ATTACK_AREA_POSITION
		attack_area_polygon.scale.x = 1
	elif velocity.x < 0:
		texture.flip_h = true
		attack_area_polygon.position.x = -ATTACK_AREA_POSITION
		attack_area_polygon.scale.x = -1

func can_combo_true() -> void:
	can_combo = true

func move() -> void:
	if direction != 0:
		fsm.change_state(move_state)

func toggle_move():
	if PlayerVariables.move:
		PlayerVariables.move = false
	else:
		PlayerVariables.move = true
