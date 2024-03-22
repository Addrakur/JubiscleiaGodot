class_name SpearSkeletonDeath
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("dead")
	skeleton.limit.erase(skeleton)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	skeleton.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "dead":
		skeleton.queue_free()
