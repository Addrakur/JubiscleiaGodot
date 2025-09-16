extends CharacterBody2D

@export_enum("water","fire","earth","air") var element: String
@export var health_component: Node2D
@export var top_size_y: float
@export var bot_size_y: float
@export var left_size_x: float
@export var right_size_x: float
@onready var fsm = $StateMachine as StateMachine
@onready var idle_state = $StateMachine/DummyIdleState as DummyIdleState
@onready var hit_state = $StateMachine/DummyHitState as DummyHitState
@onready var state = $StateMachine/State as State
@onready var hit_modulate = $HitModulate
@onready var poise_timer = $PoiseTimer
@onready var center_damage_area: Marker2D = $center_damage_area
@onready var texture: Sprite2D = $texture

var alive: bool = true

var gravity: float
var gravity_mult: float = 4

var speed: float = 1

func _ready():
	gravity = GameSettings.default_gravity

func _process(_delta):
	if health_component.is_getting_hit and not fsm.state == hit_state:
		fsm.change_state(hit_state)
	
	if Input.is_physical_key_pressed(KEY_0):
		GameSettings.player.health_component.update_health(1,200,1 if GameSettings.player.position.x > position.x else -1, "dummy",10,position.x,self)

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.true_max_poise
