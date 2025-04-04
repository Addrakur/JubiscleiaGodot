class_name BossTree
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_area: AttackArea
@export_enum("water","fire","earth","air") var element: String
@export var player: Player

@export var limit: Area2D
@onready var texture: Sprite2D = $texture

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/idle
@onready var move_state: LimboState = $hsm/move

@onready var player_ref: Player
var player_on_limit: bool = false
var can_attack_melee: bool = false
var can_attack_ranged: bool = false

func _ready() -> void:
	init_state_machine()
	player_ref = player

func _physics_process(_delta: float) -> void:
	move_and_slide()

func init_state_machine():
	hsm.add_transition(idle_state,move_state, &"idle_to_move")
	
	hsm.add_transition(move_state,idle_state, &"move_to_idle")
	
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
