extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D
@export var direction: float

@onready var limit: Area2D = get_parent()
@onready var texture: Sprite2D = $Texture
@onready var collision: CollisionShape2D = $Collision
const C_POSITION: float = -9
@onready var attack_area_collision: CollisionShape2D = $AttackArea/AttackCollision
const AAC_POSITION: float = -41.812
@onready var can_attack_area_1: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = -38
@onready var can_chase_area: CollisionShape2D = $ChaseArea/CanChaseArea
const CCA_POSITION: float = -48
@onready var attack_timer: Timer = $AttackTimer

@onready var fsm: StateMachine = $StateMachine as StateMachine
@onready var move_state: State = $StateMachine/SnakeMove as SnakeMove
@onready var attack_state: State = $StateMachine/SnakeAttack as SnakeAttack
@onready var hit_state: State = $StateMachine/SnakeHit as SnakeHit
@onready var idle_state: State = $StateMachine/SnakeIdle as SnakeIdle
@onready var death_state: State = $StateMachine/SnakeDeath as SnakeDeath
@onready var chase_state: State = $StateMachine/SnakeChase as SnakeChase
@onready var state = $StateMachine/State as State
@onready var hit_modulate: AnimationPlayer = $HitModulate
@onready var poise_timer: Timer = $PoiseTimer

@onready var player_ref: CharacterBody2D
var can_attack_player: bool = false
var player_on_limit: bool = false
var is_attacking: bool = false

var alive: bool = true 

var gravity_mult: float = 4

func _ready():
	attack_area.attack_name = name + "hit"

func _process(_delta):
	if alive and not health_component.is_getting_hit:
		if fsm.state == move_state or fsm.state == chase_state:
			if velocity.x < 0:
				left()
			elif velocity.x > 0:
				right()
		
		if not PlayerVariables.player_alive:
			player_ref = null
	
	if not alive:
		fsm.change_state(death_state)
	
	if not is_attacking:
		attack_area_collision.disabled = true

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = GameSettings.default_gravity * delta * gravity_mult

func right():
	texture.flip_h = true
	collision.position.x = -C_POSITION
	attack_area_collision.position.x = -AAC_POSITION
	can_attack_area_1.position.x = -CAA_POSITION
	can_chase_area.position.x = -CCA_POSITION

func left():
	texture.flip_h = false
	collision.position.x = C_POSITION
	attack_area_collision.position.x = AAC_POSITION
	can_attack_area_1.position.x = CAA_POSITION
	can_chase_area.position.x = CCA_POSITION

func can_attack_area_exited(body):
	if body == player_ref:
		can_attack_player = false

func chase_area_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		player_ref = body

func chase_area_exited(body):
	if body == player_ref:
		player_ref = null

func _on_can_attack_area_body_entered(body):
	if body == player_ref:
		can_attack_player = true

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""

func _on_poise_timer_timeout():
	health_component.current_poise = health_component.max_poise
