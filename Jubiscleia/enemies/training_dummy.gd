extends CharacterBody2D

@export var health_component: Node2D
@onready var fsm = $StateMachine as StateMachine
@onready var idle_state = $StateMachine/DummyIdleState as DummyIdleState
@onready var hit_state = $StateMachine/DummyHitState as DummyHitState
@onready var state = $StateMachine/State as State

var alive: bool = true

var gravity: float
var gravity_mult: float = 4

func _ready():
	gravity = GameSettings.default_gravity

func _process(_delta):
	if health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult
