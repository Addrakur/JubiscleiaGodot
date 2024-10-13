extends Node2D

var direction: float
@export var animation: AnimationPlayer
@export var texture: Sprite2D
var anim_name: String

func _ready():
	animation.play(PlayerVariables.current_attack)
	anim_name = PlayerVariables.current_attack

func _process(_delta):
	if direction == -1:
		texture.flip_h = true

func on_animation_finished(anim):
	if anim == anim_name:
		queue_free()
