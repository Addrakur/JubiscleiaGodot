class_name FireReaper
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_area: AttackArea
@export_enum("water","fire","earth","air") var element: String

@onready var limit: EnemyLimit = get_parent()
@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision
@onready var attack_polygon: CollisionPolygon2D = $AttackArea/CollisionPolygon2D
@onready var can_attack_collision: CollisionPolygon2D = $can_attack_area/can_attack_collision
@onready var animation: AnimationPlayer = $animation
@onready var can_chase_collision: CollisionPolygon2D = $can_chase_area/can_chase_collision
@onready var can_chase_collision_open: CollisionPolygon2D = $can_chase_area/can_chase_collision_open
@onready var hit_modulate: AnimationPlayer = $hit_modulate

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/fire_reaper_idle
@onready var walk_state: LimboState = $hsm/fire_reaper_walk
@onready var attack_state: LimboState = $hsm/fire_reaper_attack
@onready var chase_state: LimboState = $hsm/fire_reaper_chase
@onready var hit_state: LimboState = $hsm/fire_reaper_hit
@onready var death_state: LimboState = $hsm/fire_reaper_death

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_chase_area: bool = false
var player_on_limit: bool = false
var can_attack: bool = true
var can_move: bool = false

var alive: bool = true 

var speed: float = 1
var direction: float

func _ready() -> void:
	init_state_machine()

func _process(_delta):
	if not alive:
		hsm.dispatch("die")
	
	if alive and not health_component.is_getting_hit:
		if hsm.get_active_state() == walk_state or hsm.get_active_state() == chase_state:
			if velocity.x < 0:
				left()
			elif velocity.x > 0:
				right()
	
	if not PlayerVariables.player_alive:
		player_ref = null
	
	if not player_on_limit:
		can_attack_player = false
		player_on_chase_area = false

func left():
	texture.flip_h = false
	attack_polygon.scale.x = 1
	can_attack_collision.scale.x = 1
	can_chase_collision.scale.x = 1

func right():
	texture.flip_h = true
	attack_polygon.scale.x = -1
	can_attack_collision.scale.x = -1
	can_chase_collision.scale.x = -1

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta

func init_state_machine():
	hsm.add_transition(idle_state, walk_state, &"idle_to_walk")
	hsm.add_transition(idle_state, attack_state, &"idle_to_attack")
	hsm.add_transition(idle_state, chase_state, &"idle_to_chase")
	
	hsm.add_transition(walk_state, idle_state, &"walk_to_idle")
	
	hsm.add_transition(attack_state, idle_state, &"attack_to_idle")
	
	hsm.add_transition(chase_state, idle_state, &"chase_to_idle")
	
	hsm.add_transition(hsm.ANYSTATE, hit_state, &"apply_knockback")
	hsm.add_transition(hit_state,idle_state, &"hit_to_idle")
	
	hsm.add_transition(hsm.ANYSTATE, death_state, &"die")
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_can_attack_area_body_entered(body: Node2D) -> void:
	if body is Player and player_on_limit:
		can_attack_player = true

func _on_can_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		can_attack_player = false

func _on_can_chase_area_body_entered(body: Node2D) -> void:
	if body is Player and player_on_limit:
		print("player na area")
		player_on_chase_area = true
		player_ref = body
		set_deferred(str(can_chase_collision_open.disabled), false)
		set_deferred(str(can_chase_collision.disabled), true)

func _on_can_chase_area_body_exited(body: Node2D) -> void:
	if body is Player and not player_on_limit:
		player_on_chase_area = false
		player_ref = null
		set_deferred(str(can_chase_collision_open.disabled), true)
		set_deferred(str(can_chase_collision.disabled), false)

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""
