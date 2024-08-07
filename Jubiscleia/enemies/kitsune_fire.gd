extends Node2D

@export var move: bool
@export var animation_level: float
@export var speed: float
@onready var animation = $Animation
@onready var texture = $Texture
@onready var collision = $AttackArea/CollisionPolygon2D
@onready var attack_area = $AttackArea

var can_destroy: bool = false
var base_anim_finish: bool = false

var direction: float = 1

func _ready():
	animation.play(str(animation_level))
	attack_area.attack_name = "kitsune + " + str(animation_level)

func _physics_process(delta):
	if move:
		position.x += direction * speed * delta
	
	if can_destroy:
		animation.play(str(animation_level) + "_finish")
	

func _on_animation_finished(anim_name):
	if anim_name == str(animation_level) + "_finish":
		queue_free()
	
	if anim_name == str(animation_level):
		can_destroy = true
