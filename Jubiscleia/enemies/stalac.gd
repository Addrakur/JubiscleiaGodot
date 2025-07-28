class_name Stalac
extends CharacterBody2D
 
@export var health_component: HealthComponent
@export var attack_area: AttackArea
@export_enum("water","fire","earth","air") var element: String

@onready var limit: EnemyLimit = get_parent()
@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/stalac_idle
@onready var walk_state: LimboState = $hsm/stalac_walk
@onready var chase_state: LimboState = $hsm/stalac_chase
@onready var inactive_state: LimboState = $hsm/stalac_inactive
@onready var fall_attack_state: LimboState = $hsm/stalac_fall_attack
@onready var attack_state: LimboState = $hsm/stalac_dash_attack

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var player_on_chase_area: bool = false
var can_attack: bool = true
var can_chase: bool = false
var can_move: bool = false

var alive: bool = true 

var speed: float = 1
var direction: float

func _ready() -> void:
	init_state_machine()

func _process(delta: float) -> void:
	if not alive:
		hsm.dispatch("die")
	
	if alive:# and not health_component.is_getting_hit:
		if hsm.get_active_state() == walk_state:
			if velocity.x < 0:
				left()
			elif velocity.x > 0:
				right()
	
	if not PlayerVariables.player_alive:
		player_ref = null

func _physics_process(delta):
	if not is_on_floor() and hsm.get_active_state() != inactive_state:
		velocity.y = GameSettings.default_gravity * delta * 10
	move_and_slide()

func init_state_machine():
	hsm.add_transition(inactive_state, idle_state, &"inactive_to_idle")
	hsm.add_transition(inactive_state, fall_attack_state, &"inactive_to_fall_attack")
	
	hsm.add_transition(idle_state, attack_state, &"idle_to_attack")
	hsm.add_transition(idle_state, walk_state, &"idle_to_walk")
	hsm.add_transition(idle_state, chase_state, &"idle_to_chase")
	
	hsm.add_transition(walk_state, idle_state, &"walk_to_idle")
	
	hsm.add_transition(chase_state, idle_state, &"chase_to_idle")
	
	hsm.add_transition(fall_attack_state, idle_state, &"fall_attack_to_idle")
	
	hsm.initial_state = inactive_state
	hsm.initialize(self)
	hsm.set_active(true)

func left():
	texture.flip_h = false

func right():
	texture.flip_h = true

func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_can_attack_area_body_entered(body: Node2D) -> void:
	if body is Player and player_on_limit:
		can_attack_player = true

func _on_can_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		can_attack_player = false

func _on_chase_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_on_chase_area = true
		player_ref = body

func _on_chase_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_on_chase_area = false
		player_ref = null

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""
