extends CharacterBody2D

@export var health_component: Node2D
@export var attack_area: Area2D

@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var attack_area_collision: CollisionShape2D = $AttackArea/AttackCollision
const AAC_POSITION: float = 68
@onready var detection_area_collision: CollisionShape2D = $DetectionArea/DetectionCollision
const DAC_POSITION: float = 104
@onready var can_attack_area: CollisionShape2D = $CanAttackArea/CanAttackCollision
const CAA_POSITION: float = 56
var player_ref: CharacterBody2D

@export var speed: float

var player_on_chase_range: bool
var player_on_attack_range: bool = false
var player_on_limit: bool = false

var is_attacking: bool = false

var direction: float

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	if health_component.alive:
		health_component.die()

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y = gravity * delta
	
	if !health_component.alive or health_component.is_getting_hit:
		return
	
	flip()
		
	if !is_attacking:
		if player_on_limit && player_ref != null && player_ref.health_component.alive:
			if player_on_chase_range:
				if player_on_attack_range:
					attack()
				else:
					chase_player()
			else:
				idle()
		else:
			idle()
			

func idle() -> void:
	animation.play("idle")
	velocity.x = 0

func chase_player() -> void:
	animation.play("chase")
	if player_ref.position.x > position.x:
		direction = 1
	else:
		direction = -1
	velocity.x = direction * speed

func attack() -> void:
	is_attacking = true
	velocity.x = 0
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
		player_ref = body
		player_on_chase_range = true

func on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null
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
	if anim_name == "hit":
		health_component.is_getting_hit = false
