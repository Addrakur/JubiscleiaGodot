class_name BossTree
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_area: AttackArea
@export_enum("water","fire","earth","air") var element: String
@export var player: Player
@export var arena_middle: Marker2D

@export var limit: Area2D
@onready var texture: Sprite2D = $texture
@onready var melee_detect_area: Area2D = $melee_detect_area
@onready var ranged_detect_area: Area2D = $ranged_detect_area
@onready var rock_position: Marker2D = $rock_position

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/idle
@onready var swipe_state: LimboState = $hsm/attack_swipe

@onready var player_ref: Player
var target: Node2D
var player_on_limit: bool = false
var can_attack_melee: bool = false
var can_attack_ranged: bool = false
var rock = preload("res://enemies/tree_boss_rock.tscn")

func _ready() -> void:
	init_state_machine()
	player_ref = player

func _physics_process(_delta: float) -> void:
	if velocity.x > 0:
		right()
	elif velocity.x < 0:
		left()
	move_and_slide()

func init_state_machine():
	hsm.add_transition(idle_state, swipe_state, &"idle_to_swipe")
	
	hsm.add_transition(swipe_state, idle_state, &"swipe_to_idle")
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func _on_melee_detect_area_body_entered(body: Node2D) -> void:
	if body == player_ref:
		can_attack_melee = true

func _on_melee_detect_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		can_attack_melee = false

func _on_ranged_detect_area_body_entered(body: Node2D) -> void:
	if body == player_ref:
		can_attack_ranged = true

func _on_ranged_detect_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		can_attack_ranged = false

func right():
	texture.flip_h = true
	melee_detect_area.scale.x = -1
	ranged_detect_area.scale.x = -1

func left():
	texture.flip_h = false
	melee_detect_area.scale.x = 1
	ranged_detect_area.scale.x = 1

func spawn_rock():
	var proj = rock.instantiate()
	proj.position = rock_position.global_position
	proj.starting_pos = proj.position #Usado pra medir o range do ataque
	proj.direction = 1 if player_ref.position.x > position.x else -1
