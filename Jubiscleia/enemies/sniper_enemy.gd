class_name SniperEnemy
extends CharacterBody2D

@export_enum("water","fire","earth","air") var element: String
@export var health_component: Node2D
var direction: float

@onready var limit: Area2D = get_parent()
@onready var body_texture: Sprite2D = $body_texture
@onready var arm_texture: Sprite2D = $arm_texture
@onready var laser: Line2D = $laser
@onready var raycast: RayCast2D = $arm_texture/RayCast
@onready var hit_modulate: AnimationPlayer = $hit_modulate

@onready var hsm: LimboHSM = $HSM
@onready var idle_state: SniperEnemyIdle = $HSM/SniperEnemyIdle
@onready var attack_state: SniperEnemyAttack = $HSM/SniperEnemyAttack
@onready var death_state: SniperEnemyDeath = $HSM/SniperEnemyDeath

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

var speed: float = 1

func _ready() -> void:
	init_state_machine()

func _physics_process(_delta: float) -> void:
	if not alive:
		hsm.dispatch("die")
	
	set_direction()
	flip_body()
	if player_ref != null:
		rotate_arm()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	

func init_state_machine():
	hsm.add_transition(idle_state, attack_state, &"idle_to_attack")
	hsm.add_transition(attack_state,idle_state, &"attack_to_idle")
	hsm.add_transition(hsm.ANYSTATE,death_state, &"die")
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func set_direction():
	if $laser.points[1].x > 0:
		direction = 1
	else:
		direction = -1

func flip_body():
	if direction == 1:
		body_texture.flip_h = true
	else:
		body_texture.flip_h = false

func rotate_arm():
	if player_on_limit:
		arm_texture.rotation = arm_texture.global_position.direction_to(player_ref.global_position + Vector2(0, -16)).angle()
	
	if raycast.is_colliding():
		var collision_point: Vector2 = raycast.get_collision_point()
		laser.points[1] = collision_point - global_position + Vector2(0,16)

func _on_hit_modulate_animation_finished(_anim_name): # Deixar
	health_component.last_attack = ""
