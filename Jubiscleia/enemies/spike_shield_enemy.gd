class_name SpikeShieldEnemy
extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D

var direction: float = -1

@onready var limit: Area2D = get_parent()
@onready var animation: AnimationPlayer = $animation
@onready var attack_timer: Timer = $attack_timer
@onready var poise_timer: Timer = $poise_timer
@onready var idle_timer: Timer = $idle_timer
@onready var hit_modulate: AnimationPlayer = $hit_modulate
@onready var texture: Sprite2D = $texture
@onready var collision: CollisionPolygon2D = $collision
@onready var shield_collision: CollisionPolygon2D = $AttackArea/shield_collision
@onready var detect_collision: CollisionPolygon2D = $detect_area/detect_collision
@onready var can_attack_collision: CollisionPolygon2D = $can_attack_area/can_attack_collision

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var idle_state: SpikeShieldEnemyIdle = $StateMachine/SpikeShieldEnemyIdle
@onready var walk_state: SpikeShieldEnemyWalk = $StateMachine/SpikeShieldEnemyWalk
@onready var attack_state: SpikeShieldEnemyAttack = $StateMachine/SpikeShieldEnemyAttack
@onready var turn_state: SpikeShieldEnemyTurn = $StateMachine/SpikeShieldEnemyTurn

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

func _process(_delta):
	if not health_component.is_getting_hit and alive:
		if direction == -1:
			left()
		elif direction == 1:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	#if not alive:
	#	fsm.change_state(death_state)

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = true
	collision.scale.x = -1
	shield_collision.scale.x = -1
	detect_collision.scale.x = -1
	can_attack_collision.scale.x = -1

func left():
	texture.flip_h = false
	collision.scale.x = 1
	shield_collision.scale.x = 1
	detect_collision.scale.x = 1
	can_attack_collision.scale.x = 1

func player_behind(parent: SpikeShieldEnemy) -> bool:
	if parent.player_ref != null:
		if parent.direction == 1 and parent.player_ref.position.x < parent.position.x or parent.direction == -1 and parent.player_ref.position.x > parent.position.x:
			return true
		else:
			return false
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
	if body.is_in_group("player") and player_on_limit:
		can_attack_player = true

func _on_can_attack_area_body_exited(body: Node2D) -> void: # Deixar
	if body.is_in_group("player"):
		can_attack_player = false
