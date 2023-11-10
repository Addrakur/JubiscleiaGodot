class_name Player
extends CharacterBody2D

@export var attack_area: Area2D
@export var health_component: Node2D

@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var camera: Camera2D = $Camera
@onready var attack_area_polygon: CollisionPolygon2D = $AttackArea/Sword_Area_1
const ATTACK_AREA_POSITION: float = 39

@onready var move_state: State = $StateMachine/Move as PlayerMove
@onready var idle_state: State = $StateMachine/Idle as PlayerIdle
@onready var jump_state: State = $StateMachine/Jump as PlayerJump
@onready var fall_state: State = $StateMachine/Fall as PlayerFall
@onready var double_jump_state: State = $StateMachine/DoubleJump as PlayerDoubleJump
@onready var crouch_state: State = $StateMachine/Crouch as PlayerCrouch
@onready var hit_state: State = $StateMachine/Hit as PlayerHit
@onready var death_state: State = $StateMachine/Death as PlayerDeath
@onready var skill_1_attack_1_state: State = $StateMachine/Skill1Attack1 as PlayerSkill1Attack1
@onready var skill_1_attack_2_state: State = $StateMachine/Skill1Attack2 as PlayerSkill1Attack2
@onready var skill_1_attack_3_state: State = $StateMachine/Skill1Attack3 as PlayerSkill1Attack3
@onready var skill_2_attack_1_state: State = $StateMachine/Skill2Attack1 as PlayerSkill2Attack1
@onready var skill_2_attack_2_state: State = $StateMachine/Skill2Attack2 as PlayerSkill2Attack2
@onready var skill_2_attack_3_state: State = $StateMachine/Skill2Attack3 as PlayerSkill2Attack3
@onready var fsm: StateMachine = $StateMachine as StateMachine

@export_group("Jump Variables")
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var max_jump_count: float
var jump_count: float = 0
var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

var alive: bool = true
var combo_1: bool
var combo_2: bool
var can_combo: bool

var direction: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameSettings.player_alive = true
	
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1
	fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1
	
func _process(_delta):
	flip()
	if !alive:
		health_component.die()

func _physics_process(delta):
	if !alive:
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	get_gravity()

func get_gravity():
	if velocity.y < 0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity

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
