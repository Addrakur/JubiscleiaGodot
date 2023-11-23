extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float

@onready var attack_timer: Timer = $AttackTimer
@onready var texture: Sprite2D = $Texture

@onready var fly_state: State = $StateMachine/VultureFly as VultureFly

@onready var player_ref: CharacterBody2D

var alive: bool = true

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(_delta):
	if !health_component.is_getting_hit:
		if velocity.x < 0:
			left()
		elif velocity.x > 0:
			right()

func _physics_process(delta):
	move_and_slide()

func right():
	texture.flip_h = true

func left():
	texture.flip_h = false
