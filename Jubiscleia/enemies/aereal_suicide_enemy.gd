class_name AerealSuicideEnemy
extends CharacterBody2D

@export var attack_area: AttackArea
@export var point_left: Marker2D
@export var point_right: Marker2D
@export var direction: float

@onready var limit: Area2D = get_parent()
@onready var player_ref: CharacterBody2D
var player_on_limit: bool = false
var can_destroy: bool = false
var fixed_y: float

@onready var hsm: LimboHSM = $HSM
@onready var patrol_state: AerealSuicideEnemyPatrol = $HSM/AerealSuicideEnemyPatrol
@onready var attack_state: AerealSuicideEnemyAttack = $HSM/AerealSuicideEnemyAttack
@onready var explode_state: AerealSuicideEnemyExplode = $HSM/AerealSuicideEnemyExplode

func _ready() -> void:
	fixed_y = position.y
	init_state_machine()

func _physics_process(_delta: float) -> void:
	if can_destroy:
		hsm.dispatch("explode")
	move_and_slide()

func init_state_machine():
	hsm.add_transition(patrol_state,attack_state, &"patrol_to_attack")
	hsm.add_transition(hsm.ANYSTATE, explode_state, &"explode")
	
	hsm.initial_state = patrol_state
	hsm.initialize(self)
	hsm.set_active(true)

func _on_trigger_area_body_entered(_body: Node2D) -> void:
	can_destroy = true

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explode":
		limit.erase(self)
		queue_free()
