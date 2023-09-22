extends CharacterBody2D

@export var speed: float = 300.0

@export_group("Jump Variables")
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@export var jump_time_to_peak_mult: float
var first_jump: bool
var double_jump: bool

var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

var jump_timer: float = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1
	fall_gravity = ((-2.0 * jump_height) / pow(jump_time_to_descent,2)) * -1
	
func _physics_process(delta):
	get_gravity()
	
	move_player(delta)
	
	move_and_slide()

func move_player(delta) -> void:
	var direction = Input.get_axis("left","right")  # Verifica para qual direcao o jogador precisa ir
	
	if not is_on_floor():  # Faz o player ser afetado pela gravidade
		velocity.y += gravity * delta
		first_jump = false
	else:
		first_jump = true
		double_jump = true
		jump_timer = 0
	
	if Input.is_action_pressed("jump"):
		if first_jump && jump_timer < jump_time_to_peak * jump_time_to_peak_mult:
			velocity.y = jump_velocity
			jump_timer += delta
		elif double_jump && jump_timer < jump_time_to_peak * jump_time_to_peak_mult:
			velocity.y = jump_velocity
			jump_timer += delta
	
	velocity.x = direction * speed
	
func get_gravity():
	if velocity.y < 0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity
