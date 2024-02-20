class_name BigWormDeath
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play(big_worm.normal_or_fire + "_death")
	big_worm.limit.erase(big_worm)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	big_worm.velocity.x = 0

func _on_animation_finished(anim):
	if anim == big_worm.normal_or_fire + "_death":
		big_worm.queue_free()
