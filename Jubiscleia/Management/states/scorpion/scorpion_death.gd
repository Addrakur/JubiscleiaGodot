class_name ScorpionDeath
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("death")
	scorpion.limit.erase(scorpion)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	scorpion.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "death":
		scorpion.queue_free()
