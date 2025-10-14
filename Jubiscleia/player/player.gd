class_name Player
extends CharacterBody2D

@export var attack_area: PlayerAttackArea
@export var health_component: HealthComponent
@export var camera: Camera2D
@export var top_size_y: float
@export var bot_size_y: float
@export var left_size_x: float
@export var right_size_x: float

@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var attack_area_polygon: CollisionPolygon2D = $player_attack_area/AttackArea
const ATTACK_AREA_POSITION: float = 39
@onready var attack_spawn_point = $AttackSpawnPoint
@onready var combo_timer = $ComboTimer
@onready var coyote_time = $CoyoteTime
@onready var inv_timer = $InvTimer
@onready var wall_grab_ray_cast = $WallGrab
@onready var direction_0 = $Direction0
@onready var hit_modulate = $HitModulate
@onready var poise_timer = $PoiseTimer
@onready var collision: CollisionShape2D = $Collision
@onready var camera_methods: CameraMethods = $camera_methods
@onready var attack_number: Label = $AttackNumber
@onready var element_manager: ElementManager = $element_manager
@onready var element_meter_orb: TextureProgressBar = $element_meter_orb
@onready var element_meter_orb_2: TextureProgressBar = $element_meter_orb2

@onready var dash_cooldown: Timer = $DashCooldown

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
@onready var wall_sensor: RayCast2D = $wall_sensor
@onready var heal_state: PlayerHeal = $StateMachine/Heal
@onready var state = $StateMachine/State as State
@onready var death_menu: CanvasLayer = $death_menu

@export_category("Jump Variables")
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
var max_jump_count: float = 2
var jump_count: float = 0
var jump_velocity: float
var jump_gravity: float
var fall_gravity: float
var override_gravity: float = 0
var next_attack: int = 1

var alive: bool = true
var can_combo: bool
var can_dash: bool = true
var can_flip: bool = true

var direction: float
var last_direction: float = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float

func _ready():
	last_direction = 1
	PlayerVariables.player = self
	PlayerVariables.player_alive = true
	PlayerVariables.player_max_life = health_component.max_health
	PlayerVariables.player_current_life = health_component.current_health
	PlayerVariables.can_attack = true
	
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1
	fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1
	
func _process(_delta):
	if PlayerVariables.active:
		direction = Input.get_axis("left","right")
		
		if Input.is_action_just_pressed("dash") and can_dash:
			if fsm.state == wall_grab_state:
				direction = -wall_grab_ray_cast.scale.x
			fsm.change_state(dash_state)
	
	if not PlayerVariables.player_attacking:
		attack_area_polygon.disabled = true
	
	PlayerVariables.player_current_life = health_component.current_health
	
	if can_flip:
		flip()
	
	if not alive:
		fsm.change_state(death_state)
	

func _physics_process(delta):
	if not is_on_floor():
		set_gravity()
		velocity.y += gravity * delta
	if alive:
		move_and_slide()
		if not PlayerVariables.player_attacking:
			direction_fix()
	
func set_gravity():
	if override_gravity == 0:
		if velocity.y < 0:
			gravity = jump_gravity
		else:
			gravity = fall_gravity
	else:
		gravity = override_gravity
	
func flip() -> void:
	if PlayerVariables.current_attack == "" and velocity.x > 0 or not PlayerVariables.current_attack == "" and direction == 1:
		texture.flip_h = false
		attack_area_polygon.position.x = ATTACK_AREA_POSITION
		attack_area_polygon.scale.x = 1
		wall_grab_ray_cast.scale.x = 1
		wall_sensor.scale.x = 1
	elif PlayerVariables.current_attack == "" and velocity.x < 0 or not PlayerVariables.current_attack == "" and direction == -1:
		texture.flip_h = true
		attack_area_polygon.position.x = -ATTACK_AREA_POSITION
		attack_area_polygon.scale.x = -1
		wall_grab_ray_cast.scale.x = -1
		wall_sensor.scale.x = -1

func can_combo_true() -> void: #Vinculado aos ataques
	can_combo = true

func move() -> void: #Vinculado aos ataques
	if direction != 0:
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
	can_flip = false

func player_attacking_false():
	PlayerVariables.player_attacking = false

func player_inv_true():
	health_component.invulnerable = true

func player_inv_false():
	health_component.invulnerable = false

func direction_fix():
	if direction > 0:
		direction = 1
	elif direction < 0:
		direction = -1
	
	if direction != 0:
		last_direction = direction

func spawn_attack_projectile(player_direction: bool):
	var proj = Paths.projectile.instantiate()
	add_child(proj)
	proj.position = global_position + PlayerVariables.get(PlayerVariables.current_attack + "_location")
	proj.starting_pos = proj.position #Usado pra medir o range do ataque
	proj.direction = last_direction if player_direction else -last_direction
	proj.collision_area.scale.x = proj.direction
	proj.texture.flip_h = true if proj.direction == -1 else false

func spawn_point_location_change():
	var spawn_direction: float = direction if direction != 0 else last_direction
	attack_spawn_point.position.x = PlayerVariables.get(PlayerVariables.current_attack + "_location").x * spawn_direction
	attack_spawn_point.position.y = PlayerVariables.get(PlayerVariables.current_attack + "_location").y

func _play_animation(anim_name: String) -> void:
	animation.play(anim_name, -1, PlayerVariables.attack_speed, false)

func reset_player_variables():
	PlayerVariables.player_attacking = false
	PlayerVariables.last_skill = PlayerVariables.current_skill
	PlayerVariables.current_attack = ""
	PlayerVariables.current_skill = ""
	PlayerVariables.move = false
	PlayerVariables.player_reduce_damage = false
	PlayerVariables.player_parry = false
	PlayerVariables.immune_to_poise_damage = false
	PlayerVariables.player_charge_attack_start = false
	PlayerVariables.anim_finish = false
	can_flip = true

func _on_dash_cooldown_timeout():
	can_dash = true

func _on_combo_timer_timeout():
	next_attack = 1
	attack_number.text = "1"

func _on_inv_timer_timeout():
	health_component.invulnerable = false

func hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.max_poise

func combo_timer_start():
	combo_timer.wait_time = Parameters.player_combo_memory_time
	combo_timer.start()

func parry_true():
	PlayerVariables.player_parry = true

func parry_false():
	PlayerVariables.player_parry = false

func reduce_damage_true():
	PlayerVariables.player_reduce_damage = true

func reduce_damage_false():
	PlayerVariables.player_reduce_damage = false

func immune_to_poise_true():
	PlayerVariables.immune_to_poise_damage = true

func immune_to_poise_false():
	PlayerVariables.immune_to_poise_damage = false

func charge_attack_true():
	PlayerVariables.player_charge_attack_start = true

func set_attack_level(level: int):
	attack_area.damage = PlayerVariables.get(PlayerVariables.current_attack + "_damage_level_" + str(level))
	attack_area.poise_damage = PlayerVariables.get(PlayerVariables.current_attack + "_poise_level_" + str(level))
	attack_area.knockback_force = PlayerVariables.get(PlayerVariables.current_attack + "_knockback_level_" + str(level))
