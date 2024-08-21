extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var skeleton_collision: CollisionShape2D = $SkeletonCollision
@onready var hit_modulate = $HitModulate
@onready var poise_timer = $PoiseTimer
@onready var attack_collision: CollisionPolygon2D = $AttackArea/AttackCollision
@onready var detect_collision: CollisionPolygon2D = $DetectArea/DetectCollision
@onready var can_attack_collision: CollisionPolygon2D = $CanAttackArea/CanAttackCollision
@onready var animations: AnimationPlayer = $Animations
@onready var protect_cooldown: Timer = $ProtectCooldown

@onready var fsm: StateMachine = $StateMachine
@onready var walk_state: State = $StateMachine/SwordSkeletonWalk as SwordSkeletonWalk
@onready var idle_state: State = $StateMachine/SwordSkeletonIdle as SwordSkeletonIdle
@onready var run_state: State = $StateMachine/SwordSkeletonRun as SwordSkeletonRun
@onready var attack_state: State = $StateMachine/SwordSkeletonAttack as SwordSkeletonAttack
@onready var hit_state: State = $StateMachine/SwordSkeletonHit as SwordSkeletonHit
@onready var death_state: State = $StateMachine/SwordSkeletonDeath as SwordSkeletonDeath
@onready var protect_state: State = $StateMachine/SwordSkeletonProtect as SwordSkeletonProtect
@onready var state = $StateMachine/State as State

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var can_protect: bool = true
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true 

var gravity: float
var gravity_mult: float = 4

func _ready():
	pass

func _process(_delta):
	if not health_component.is_getting_hit and alive:
		if direction == -1:
			left()
		elif direction == 1:
			right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	if not alive:
		fsm.change_state(death_state)
	
	if not is_attacking:
		attack_collision.disabled = true

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = false
	skeleton_collision.scale.x = 1
	attack_collision.scale.x = 1
	can_attack_collision.scale.x = 1
	detect_collision.scale.x = 1

func left():
	texture.flip_h = true
	skeleton_collision.scale.x = -1
	attack_collision.scale.x = -1
	can_attack_collision.scale.x = -1
	detect_collision.scale.x = -1

func _on_detect_area_body_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = body

func _on_detect_area_body_exited(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = null

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.max_poise
  
func _on_can_attack_area_body_entered(body: Node2D) -> void:
	if body == player_ref:
		can_attack_player = true

func _on_can_attack_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		can_attack_player = false

func _on_protect_cooldown_timeout() -> void:
	can_protect = true
