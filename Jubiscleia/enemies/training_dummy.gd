extends CharacterBody2D

@export var health_component: Node2D
@onready var fsm = $StateMachine as StateMachine
@onready var idle_state = $StateMachine/DummyIdleState as DummyIdleState
@onready var hit_state = $StateMachine/DummyHitState as DummyHitState
@onready var state = $StateMachine/State as State
@onready var hit_modulate = $HitModulate
@onready var poise_timer = $PoiseTimer

var alive: bool = true

var gravity: float
var gravity_mult: float = 4

func _ready():
	set_parameters()
	gravity = GameSettings.default_gravity

func _process(_delta):
	if health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.true_max_poise

func set_parameters():
	health_component.true_max_health = Parameters.dummy_max_health #player_max_health
	health_component.true_max_poise = Parameters.dummy_max_poise #player_max_poise
