extends Node2D

var speed: float
var move: bool = true
var direction: float
@export var animation: AnimationPlayer
@export var texture: Sprite2D
@export var collision_area: CollisionPolygon2D
@export var attack_area: PlayerAttackArea

var can_destroy: bool = false
var attack: String = PlayerVariables.current_attack
var skill: String = PlayerVariables.current_skill

var starting_pos: Vector2

var max_distance: float

var element: String

func _ready():
	animation.play(attack)
	max_distance = PlayerVariables.get(attack + "_projectile_max_distance")
	attack_area.damage = PlayerVariables.get(attack + "_projectile_damage")
	attack_area.knockback_force = PlayerVariables.get(attack + "_projectile_knockback")
	attack_area.poise_damage = PlayerVariables.get(attack + "_projectile_poise")
	speed = PlayerVariables.get(attack + "_projectile_speed")
	element = PlayerVariables.get(PlayerVariables.current_skill + "_element")
	attack_area.current_element = element
	attack_area.attack_name = name
	

func _physics_process(delta):
	if move:
		position.x += direction * speed * delta
	
	if direction == -1:
		texture.flip_h = true
	
	if can_destroy:
		animation.play(attack + "_finish")
		attack_area.attack_name = name + "_finish"
	
	if abs(global_position.x - starting_pos.x) > max_distance:
		can_destroy = true

func _on_animation_finished(anim):
	if anim == attack + "_finish":
		queue_free()
	
	#if anim == attack:
		#can_destroy = true
