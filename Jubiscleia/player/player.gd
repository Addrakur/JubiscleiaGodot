extends CharacterBody2D

@onready var jump_cd: Timer = $JumpCD

@export var speed: float = 300.0
@export var jump_force: float = -400.0
@export var jump_count: float
@export var max_jump_count: float

@export var can_jump: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	move_player(delta)
	
	move_and_slide()

func move_player(delta) -> void:
	var direction = Input.get_axis("left","right")  # Verifica para qual direcao o jogador precisa ir
	
	if not is_on_floor():  # Faz o player ser afetado pela gravidade
		velocity.y += gravity * delta
	else:
		can_jump = true
		jump_count = 0
	
	#if Input.is_action_just_pressed("jump") and jump_count < max_jump_count: # Faz o player pular
	#	velocity.y = jump_force
	#	jump_count += 1
	
	if Input.is_action_pressed("jump") and jump_count < max_jump_count:
		velocity.y = jump_force
		jump_count += 1
	
	velocity.x = direction * speed
	
