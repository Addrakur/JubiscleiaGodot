extends Node2D

@export var speed: float
var direction: float
@export var animation: AnimationPlayer
@export var texture: Sprite2D
@export var collision_area: CollisionPolygon2D
@export var attack_area: Area2D

var can_destroy: bool = false

func _ready():
	animation.play(PlayerVariables.current_attack)
	attack_area.damage = PlayerVariables.get(PlayerVariables.current_attack + "_projectile_damage")
	speed = PlayerVariables.get(PlayerVariables.current_attack + "_projectile_speed")

func _physics_process(delta):
	position.x += direction * speed * delta
	if direction == -1:
		texture.flip_h = true
		collision_area.scale.x = -1
	
	if can_destroy:
		queue_free()

func _on_animation_finished(anim):
	can_destroy = true
