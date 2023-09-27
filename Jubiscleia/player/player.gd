extends CharacterBody2D

@onready var attack_area: Area2D = $AttackArea
@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var attack_area_side: CollisionShape2D = $AttackArea/AttackAreaSide
const ATTACK_AREA_SIDE_LOCATION: float = 48

@export var speed: float = 300.0

@export_group("Jump Variables")
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var jump_time_to_peak_mult: float
@export var can_double_jump: bool
var first_jump: bool
var double_jump: bool = false
var is_jumping: bool
var jump_velocity: float
var jump_gravity: float
var fall_gravity: float
var jump_timer: float = 0

@export_group("Fight Variables")
@export var life:float
@export var damage: float
@export var knockup_force: float
var is_attacking: bool = false
var knockup: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1
	fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1
	
	if can_double_jump:
		double_jump = true

func _process(_delta):
	animations()

func _physics_process(delta):
	get_gravity()
	move_player(delta)
	move_and_slide()

func move_player(delta) -> void:
	var direction = Input.get_axis("left","right")  # Verifica para qual direcao o jogador precisa ir
	
	if not is_on_floor():  # Verifica se o player esta no chao ou nao
		velocity.y += gravity * delta  # Faz o player ser afetado pela gravidade
		if not is_jumping: # Verifica se o player esta pulando ou nao
			first_jump = false # Faz o player perder o primeiro pulo caso esteja no ar e nao esteja pulando
	else:  # Indica que o player esta no chao
		first_jump = true  # Devolve o primeiro pulo para o player
		is_jumping = false  # Indica que o player nao esta pulando
		jump_timer = 0  # Reinicia o timer no pulo
		if can_double_jump:  # Verifica se o player pode usar o double jump
			double_jump = true  # Devolve o segundo pulo para o player
	
	if Input.is_action_pressed("jump") && !Input.is_action_pressed("look_down"):
		if first_jump && jump_timer < jump_time_to_peak * jump_time_to_peak_mult:
			velocity.y = jump_velocity
			jump_timer += delta
			is_jumping = true
		elif double_jump && jump_timer < jump_time_to_peak * jump_time_to_peak_mult:
			velocity.y = jump_velocity
			jump_timer += delta
			is_jumping = true
	
	if Input.is_action_just_released("jump"):
		if first_jump:
			first_jump = false
			jump_timer = 0
		elif double_jump:
			double_jump = false
	
	if Input.is_action_pressed("look_down") && is_on_floor() && Input.is_action_just_pressed("jump"):
		position.y += 1
	
	if Input.is_action_just_pressed("Basic_Attack"):
		is_attacking = true
		if Input.is_action_pressed("look_up"):
			animation.play("attack_up")
		elif Input.is_action_pressed("look_down"):
			animation.play("attack_down")
			if velocity.y != 0:
				knockup = true
		else:
			animation.play("attack_side")
	
	velocity.x = direction * speed

func get_gravity():
	if velocity.y < 0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity

func animations() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_side.position.x = ATTACK_AREA_SIDE_LOCATION
	elif velocity.x < 0:
		texture.flip_h = true
		attack_area_side.position.x = -ATTACK_AREA_SIDE_LOCATION
	
	if is_attacking == false:
		if velocity.y != 0:
			animation.play("jump")
		elif velocity.x != 0:
			animation.play("run")
		else:
			animation.play("idle")

func on_animation_finished(anim_name):
	if anim_name == "attack_side" or anim_name == "attack_up" or anim_name == "attack_down":
		is_attacking = false
		knockup = false

func _on_attack_area_body_entered(body):
	if body.is_in_group("enemy"):
		if knockup:
			velocity.y = knockup_force
