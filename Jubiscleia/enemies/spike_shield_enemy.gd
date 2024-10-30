class_name SpikeShieldEnemy
extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var starting_x: Marker2D

var direction: float = -1

@onready var limit: Area2D = get_parent()
@onready var animation: AnimationPlayer = $animation
@onready var attack_timer: Timer = $attack_timer
@onready var poise_timer: Timer = $poise_timer
@onready var idle_timer: Timer = $idle_timer
@onready var hit_modulate: AnimationPlayer = $hit_modulate
@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision
@onready var shield_collision: CollisionPolygon2D = $AttackArea/shield_collision
@onready var detect_collision: CollisionPolygon2D = $detect_area/detect_collision
@onready var can_attack_collision: CollisionPolygon2D = $can_attack_area/can_attack_collision
@onready var shield_shape_collision: CollisionPolygon2D = $shield_shape_collision
@onready var turn_attack_collision: CollisionPolygon2D = $turn_attack_area/turn_attack_collision

@onready var hsm: LimboHSM = $HSM
@onready var idle_state: SpikeShieldEnemyIdle = $HSM/SpikeShieldEnemyIdle
@onready var walk_state: SpikeShieldEnemyWalk = $HSM/SpikeShieldEnemyWalk
@onready var turn_state: SpikeShieldEnemyTurn = $HSM/SpikeShieldEnemyTurn
@onready var attack_state: SpikeShieldEnemyAttack = $HSM/SpikeShieldEnemyAttack


@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false
var turn_attack: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

var move_position: float

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
	move_and_slide()

func right():
	texture.flip_h = true
	collision.position.x = 12
	shield_collision.scale.x = -1
	shield_shape_collision.scale.x = -1
	detect_collision.scale.x = -1
	can_attack_collision.scale.x = -1
	turn_attack_collision.scale.x = -1

func left():
	texture.flip_h = false
	collision.position.x = -12
	shield_collision.scale.x = 1
	shield_shape_collision.scale.x = 1
	detect_collision.scale.x = 1
	can_attack_collision.scale.x = 1
	turn_attack_collision.scale.x = 1

func move_position_behind() -> bool:
		if move_position > global_position.x and direction == -1 or move_position < global_position.x and direction == 1:
			print("behind")
			return true
		else:
			return false

func _on_detect_area_body_entered(body): # Deixar
	if body.is_in_group("player"):
		player_ref = body

func _on_detect_area_body_exited(body): # Deixar
	if body.is_in_group("player"):
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
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func new_position():
	move_position = randf_range(starting_x.global_position.x + walk_state.wander_limit, starting_x.global_position.x - walk_state.wander_limit)
	print(move_position, "           current position: ", global_position.x)

func set_direction():
	if texture.flip_h:
		direction = 1
	else:
		direction = -1
