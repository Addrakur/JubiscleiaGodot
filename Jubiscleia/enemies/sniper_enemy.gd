class_name SniperEnemy
extends CharacterBody2D

@export var health_component: Node2D
var direction: float

@onready var limit: Area2D = get_parent()
@onready var body_texture: Sprite2D = $body_texture
@onready var arm_texture: Sprite2D = $arm_texture
@onready var laser: Line2D = $laser
@onready var raycast: RayCast2D = $arm_texture/RayCast



@onready var hsm: LimboHSM = $HSM
@onready var idle_state: SniperEnemyIdle = $HSM/SniperEnemyIdle
@onready var attack_state: SniperEnemyAttack = $HSM/SniperEnemyAttack

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false

var alive: bool = true

var gravity: float

var gravity_mult: float = 4

func _ready() -> void:
	init_state_machine()

func _physics_process(_delta: float) -> void:
	if not alive:
		return
	
	set_direction()
	flip_body()
	rotate_arm()
	

func init_state_machine():
	hsm.add_transition(idle_state, attack_state, &"idle_to_attack")
	hsm.add_transition(attack_state,idle_state, &"attack_to_idle")
	
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
