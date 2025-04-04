class_name SpikeShieldEnemy
extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var starting_x: Marker2D
@export_enum("water","fire","earth","air") var element: String

var direction: float = -1

@onready var limit: Area2D = get_parent()
@onready var animation: AnimationPlayer = $animation
@onready var attack_timer: Timer = $attack_timer
@onready var poise_timer: Timer = $poise_timer
@onready var idle_timer: Timer = $idle_timer
@onready var hit_modulate: AnimationPlayer = $hit_modulate
@onready var texture: Sprite2D = $texture
@onready var shield_collision: CollisionPolygon2D = $AttackArea/shield_collision
@onready var detect_collision: CollisionPolygon2D = $detect_area/detect_collision
@onready var can_attack_collision: CollisionPolygon2D = $can_attack_area/can_attack_collision
@onready var turn_attack_collision: CollisionPolygon2D = $turn_attack_area/turn_attack_collision
@onready var center_damage_area: Marker2D = $center_damage_area
@onready var wall_cast_ground: RayCast2D = $RayCast2D
@onready var wall_cast_up: RayCast2D = $RayCast2D2


@onready var hsm: LimboHSM = $HSM
@onready var idle_state: SpikeShieldEnemyIdle = $HSM/SpikeShieldEnemyIdle
@onready var walk_state: SpikeShieldEnemyWalk = $HSM/SpikeShieldEnemyWalk
@onready var turn_state: SpikeShieldEnemyTurn = $HSM/SpikeShieldEnemyTurn
@onready var attack_state: SpikeShieldEnemyAttack = $HSM/SpikeShieldEnemyAttack
@onready var hit_state: SpikeShieldEnemyHit = $HSM/SpikeShieldEnemyHit
@onready var death_state: SpikeShieldEnemyDeath = $HSM/SpikeShieldEnemyDeath


@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false
var turn_attack: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

var move_position: float

var speed: float = 1

func _ready() -> void:
	init_state_machine()

func _process(_delta):
	if not health_component.is_getting_hit and alive:
		if velocity.x < 0:
			left()
		elif velocity.x > 0:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	#if not alive:
	#	fsm.change_state(death_state)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult
	
	if not alive:
		hsm.dispatch("die")
	
	move_and_slide()

func right():
	texture.flip_h = true
	shield_collision.scale.x = -1
	detect_collision.scale.x = -1
	can_attack_collision.scale.x = -1
	turn_attack_collision.scale.x = -1
	wall_cast_ground.scale.x = -1
	wall_cast_up.scale.x = -1

func left():
	texture.flip_h = false
	shield_collision.scale.x = 1
	detect_collision.scale.x = 1
	can_attack_collision.scale.x = 1
	turn_attack_collision.scale.x = 1
	wall_cast_ground.scale.x = 1
	wall_cast_up.scale.x = 1

func move_position_behind() -> bool:
		if move_position > global_position.x and direction == -1 or move_position < global_position.x and direction == 1:
			print("behind")
			return true
		else:
			return false

func _on_detect_area_body_entered(body): # Deixar
	if body == GameSettings.player:
		player_ref = body

func _on_detect_area_body_exited(body): # Deixar
	if body == GameSettings.player:
		player_ref = null

func _on_hit_modulate_animation_finished(_anim_name): # Deixar
	health_component.last_attack = ""

func _on_poise_timer_timeout(): # Deixar
	health_component.current_poise = health_component.max_poise
  
func _on_can_attack_area_body_entered(body: Node2D) -> void: # Deixar
	if body == player_ref and player_on_limit:
		can_attack_player = true

func _on_can_attack_area_body_exited(body: Node2D) -> void: # Deixar
	if body == player_ref:
		can_attack_player = false

func _on_turn_attack_area_body_entered(body: Node2D) -> void:
	if body == player_ref:
		turn_attack = true

func _on_turn_attack_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		turn_attack = false

func init_state_machine():
	hsm.add_transition(idle_state,walk_state, &"idle_to_walk")
	hsm.add_transition(idle_state,turn_state, &"idle_to_turn")
	hsm.add_transition(idle_state,attack_state, &"idle_to_attack")
	
	hsm.add_transition(walk_state,idle_state, &"walk_to_idle")
	hsm.add_transition(walk_state,turn_state, &"walk_to_turn")
	
	hsm.add_transition(turn_state,walk_state, &"turn_to_walk")
	hsm.add_transition(turn_state,idle_state, &"turn_to_idle")
	
	hsm.add_transition(attack_state,idle_state, &"attack_to_idle")
	
	hsm.add_transition(hsm.ANYSTATE, hit_state, &"apply_knockback")
	hsm.add_transition(hit_state,idle_state, &"hit_to_idle")
	
	hsm.add_transition(hsm.ANYSTATE, death_state, &"die")
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func new_position():
	if player_ref == null:
		move_position = randf_range(starting_x.global_position.x + walk_state.wander_limit, starting_x.global_position.x - walk_state.wander_limit)
	else:
		move_position = player_ref.global_position.x

func set_direction():
	if texture.flip_h:
		direction = 1
	else:
		direction = -1
