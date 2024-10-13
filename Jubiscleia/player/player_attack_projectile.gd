extends Node2D

@export var speed: float
@export var move: bool
var direction: float
@export var animation: AnimationPlayer
@export var texture: Sprite2D
@export var collision_area: CollisionPolygon2D
@export var attack_area: Area2D

var can_destroy: bool = false
var attack: String = PlayerVariables.current_attack

var starting_pos: Vector2

func _ready():
	animation.play(attack)
	attack_area.damage = PlayerVariables.get(attack + "_projectile_damage")
	attack_area.knockback_force = PlayerVariables.get(attack + "_projectile_knockback")
	attack_area.poise_damage = PlayerVariables.get(attack + "_projectile_poise")
	speed = PlayerVariables.get(attack + "_projectile_speed")
	
	attack_area.attack_name = name

func _physics_process(delta):
	if move:
		position.x += direction * speed * delta
	
	if direction == -1:
		texture.flip_h = true
	
	if can_destroy:
		animation.play(attack + "_finish")
		attack_area.attack_name = name + "_finish"

func _on_animation_finished(anim):
	if anim == attack + "_finish":
		print(starting_pos.distance_to(global_position)/16)
		queue_free()
	
	if anim == attack:
		can_destroy = true
