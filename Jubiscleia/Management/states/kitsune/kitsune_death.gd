class_name KitsuneDeath
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("dead")
	kitsune.limit.erase(kitsune)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	kitsune.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "dead":
		kitsune.queue_free()
