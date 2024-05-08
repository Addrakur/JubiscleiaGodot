extends Node2D

var direction: float
@export var animation: AnimationPlayer
@export var texture: Sprite2D
@export var collision_area: CollisionPolygon2D
@export var attack_area: Area2D
var anim_name: String

func _ready():
	animation.play(PlayerVariables.current_attack)
	attack_area.damage = PlayerVariables.get(PlayerVariables.current_attack + "_burst_damage")
	anim_name = PlayerVariables.current_attack

func _process(_delta):
	if direction == -1:
		texture.flip_h = true
		collision_area.scale.x = -1

func on_animation_finished(anim):
	if anim == anim_name:
		queue_free()
