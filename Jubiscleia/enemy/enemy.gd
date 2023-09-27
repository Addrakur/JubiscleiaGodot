extends CharacterBody2D

@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var attack_area_collision: CollisionShape2D = $AttackArea/AttackCollision
const AAC_POSITION: float = 68
@onready var detection_area_collision: CollisionShape2D = $DetectionArea/DetectionCollision
const DAC_POSITION: float = 144
@onready var can_attack_area: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = 56

@export var speed: float
var player_on_chase_range: bool
var player_on_attack_range: bool = false

var is_attacking: bool = false

var direction: float = randf()

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	if direction > 0.5:
		direction = 1
	else:
		direction = -1

func _physics_process(delta):
	flip()
	if not is_on_floor():
		velocity.y = gravity * delta
	
	if player_on_chase_range:
		if player_on_attack_range:
			attack()
		elif !is_attacking:
			chase_player()
	elif !is_attacking:
		idle()
	
	move_and_slide()

func idle() -> void:
	if velocity.x == 0:
		animation.play("idle")
	else:
		animation.play("run")
	
	velocity.x = direction * speed

func chase_player() -> void:
	animation.play("chase")

func attack() -> void:
	is_attacking = true
	animation.play("attack")

func flip() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_collision.position.x = AAC_POSITION
		detection_area_collision.position.x = DAC_POSITION
		can_attack_area.position.x = CAA_POSITION
		
	elif velocity.x < 0:
		texture.flip_h = true
		attack_area_collision.position.x = -AAC_POSITION
		detection_area_collision.position.x = -DAC_POSITION
		can_attack_area.position.x = -CAA_POSITION
		

func on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player_on_chase_range = true

func on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player_on_chase_range = false

func on_can_attack_area_body_entered(body):
	if body.is_in_group("player"):
		player_on_attack_range = true

func on_can_attack_area_body_exited(body):
	if body.is_in_group("player"):
		player_on_attack_range = false

func _on_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false
