class_name Player
extends CharacterBody2D

@export var attack_area: Area2D
@export var health_component: Node2D

@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var attack_area_polygon: CollisionPolygon2D = $AttackArea/AttackArea
const ATTACK_AREA_POSITION: float = 39
@onready var attack_spawn_point = $AttackSpawnPoint
@onready var combo_timer = $ComboTimer
@onready var coyote_time = $CoyoteTime
@onready var inv_timer = $InvTimer
@onready var wall_grab_ray_cast = $WallGrab

@onready var dash_cooldown: Timer = $DashCooldown
@onready var corruption_manager: Node2D = $CorruptionManager

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
@onready var dash_state: State = $StateMachine/PlayerDash as PlayerDash
@onready var wall_grab_state = $StateMachine/PlayerWallGrab
@onready var state = $StateMachine/State as State
@onready var interface = $Interface

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
var next_attack: float = 1

var alive: bool = true
var can_combo: bool
var can_dash: bool = true

var direction: float
var last_direction: float = 1

var projectile = preload("res://player/player_attack_projectile.tscn")
var spear_burst = preload("res://player/player_spear_burst.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	PlayerVariables.player = self
	PlayerVariables.player_alive = true
	PlayerVariables.player_max_life = health_component.max_health
	PlayerVariables.player_current_life = health_component.current_health
	
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1
	fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1
	#GameSettings.default_gravity = fall_gravity
	
func _process(_delta):
	direction = Input.get_axis("left","right")
	
	PlayerVariables.player_current_life = health_component.current_health
	
	if not health_component.is_getting_hit and not PlayerVariables.player_attacking:
		flip()
	
	if not alive:
		fsm.change_state(death_state)
	
	if health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)
	
	if Input.is_action_pressed("dash") and can_dash:
		if fsm.state == wall_grab_state:
			direction = -wall_grab_ray_cast.scale.x
		fsm.change_state(dash_state)
	

func _physics_process(delta):
	if not is_on_floor():
		get_gravity()
		velocity.y += gravity * delta
	if alive:
		move_and_slide()
		if not PlayerVariables.player_attacking:
			direction_fix()
	
func get_gravity():
	if override_gravity == 0:
		if velocity.y < 0:
			gravity = jump_gravity
		else:
			gravity = fall_gravity
	else:
		gravity = override_gravity
	

func flip() -> void:
	if direction > 0:
		texture.flip_h = false
		attack_area_polygon.position.x = ATTACK_AREA_POSITION
		attack_area_polygon.scale.x = 1
		wall_grab_ray_cast.scale.x = 1
	elif direction < 0:
		texture.flip_h = true
		attack_area_polygon.position.x = -ATTACK_AREA_POSITION
		attack_area_polygon.scale.x = -1
		wall_grab_ray_cast.scale.x = -1

func can_combo_true() -> void: #Vinculado aos ataques
	can_combo = true

func move() -> void: #Vinculado aos ataques
	if direction != 0:
		can_dash = true
		fsm.change_state(move_state)

func move_true():
	PlayerVariables.move = true

func move_false():
	PlayerVariables.move = false

func anim_finish_true():
	PlayerVariables.anim_finish = true

func can_dash_true():
	can_dash = true

func can_dash_false():
	can_dash = false

func player_attacking_true():
	PlayerVariables.player_attacking = true

func player_attacking_false():
	PlayerVariables.player_attacking = false

func direction_fix():
	if direction > 0:
		direction = 1
	elif direction < 0:
		direction = -1
	
	if direction != 0:
		last_direction = direction

func spawn_attack_projectile(player_direction: bool):
	var proj = projectile.instantiate()
	add_child(proj)
	proj.position = global_position + PlayerVariables.get(PlayerVariables.current_attack + "_location")
	proj.direction = last_direction if player_direction else -last_direction
	proj.collision_area.scale.x = proj.direction
	proj.texture.flip_h = true if proj.direction == -1 else false

func spawn_spear_burst(player_direction: bool):
	var burst = spear_burst.instantiate()
	add_child(burst)
	burst.position = global_position + PlayerVariables.get(PlayerVariables.current_attack + "_location")
	burst.direction = last_direction if player_direction else -last_direction

func spawn_point_location_change():
	attack_spawn_point.position.x = PlayerVariables.get(PlayerVariables.current_attack + "_location").x * last_direction
	attack_spawn_point.position.y = PlayerVariables.get(PlayerVariables.current_attack + "_location").y

func _on_dash_cooldown_timeout():
	can_dash = true

func _on_combo_timer_timeout():
	next_attack = 1

func _on_inv_timer_timeout():
	health_component.invulnerable = false
