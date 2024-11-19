extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: AttackArea
@export var direction: float
@export var contact_damage: AttackArea
@export_enum("water","fire","earth","air") var element: String

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionShape2D = $Collision
@onready var chase_area: CollisionPolygon2D = $CanChaseArea/CanChaseArea
@onready var can_attack_ground: CollisionPolygon2D = $CanAttackGround/CanAttackGroundArea
@onready var can_attack_air: CollisionPolygon2D = $CanAttackAir/CanAttackAirArea
@onready var attack_area_ground: CollisionPolygon2D = $AttackArea/AttackCollisionGround
@onready var attack_area_air: CollisionPolygon2D = $AttackArea/AttackCollisionAir
@onready var hit_modulate = $HitModulate
@onready var poise_timer = $PoiseTimer
@onready var attack_collision_air = $AttackArea/AttackCollisionAir
@onready var attack_collision_ground = $AttackArea/AttackCollisionGround
@onready var contact_area: CollisionShape2D = $ContactDamage/contact_area

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var walk_state: State = $StateMachine/SpearSkeletonWalk as SpearSkeletonWalk
@onready var idle_state: State = $StateMachine/SpearSkeletonIdle as SpearSkeletonIdle
@onready var run_state: State = $StateMachine/SpearSkeletonRun as SpearSkeletonRun
@onready var attack_state: State = $StateMachine/SpearSkeletonAttack as SpearSkeletonAttack
@onready var hit_state: State = $StateMachine/SpearSkeletonHit as SpearSkeletonHit
@onready var death_state: State = $StateMachine/SpearSkeletonDeath as SpearSkeletonDeath
@onready var state = $StateMachine/State as State

@onready var player_ref: CharacterBody2D
var can_attack_player_air: bool = false
var can_attack_player_ground: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true 

var gravity: float
var gravity_mult: float = 4


func _ready():
	set_parameters()
	attack_area.attack_name = name + "hit"

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
		attack_collision_air.disabled = true
		attack_collision_ground.disabled = true

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = false
	chase_area.scale.x = 1
	can_attack_ground.scale.x = 1
	can_attack_air.scale.x = 1
	attack_area_ground.scale.x = 1
	attack_area_air.scale.x = 1

func left():
	texture.flip_h = true
	chase_area.scale.x = -1
	can_attack_ground.scale.x = -1
	can_attack_air.scale.x = -1
	attack_area_ground.scale.x = -1
	attack_area_air.scale.x = -1

func can_chase_area_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func can_chase_area_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null

func can_attack_ground_body_entered(body):
	if body.is_in_group("player"):
		can_attack_player_ground = true

func can_attack_ground_body_exited(body):
	if body.is_in_group("player"):
		can_attack_player_ground = false

func can_attack_air_body_entered(body):
	if body.is_in_group("player"):
		can_attack_player_air = true

func can_attack_air_body_exited(body):
	if body.is_in_group("player"):
		can_attack_player_air = false

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.max_poise

func set_parameters():
	attack_area.damage = Parameters.spear_skeleton_attack_damage
	attack_area.knockback_force =  Parameters.spear_skeleton_attack_knockback
	attack_area.knockup_force = Parameters.spear_skeleton_attack_knockup
	attack_area.poise_damage = Parameters.spear_skeleton_attack_poise_damage

	contact_area.disabled = false if Parameters.spear_skeleton_contact_damage_bool == 1 else true
	contact_damage.damage = Parameters.spear_skeleton_contact_damage
	contact_damage.knockback_force = Parameters.spear_skeleton_contact_knockback
	contact_damage.knockup_force = Parameters.spear_skeleton_contact_knockup
	contact_damage.poise_damage = Parameters.spear_skeleton_contact_poise_damage
