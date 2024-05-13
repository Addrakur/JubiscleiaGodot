extends Node2D

@export var animation_level: float
@export var speed: float
@onready var animation = $Animation
@onready var texture = $Texture

var direction: float = 1

func _ready():
	animation.play(str(animation_level))

func _physics_process(delta):
	position.x += direction * speed * delta


func _on_animation_finished(anim_name):
	if anim_name == str(animation_level) + "_finish":
		queue_free()
	
	if anim_name == str(animation_level):
		finish(anim_name)

func finish(anim: String):
	animation.play(anim + "_finish")
