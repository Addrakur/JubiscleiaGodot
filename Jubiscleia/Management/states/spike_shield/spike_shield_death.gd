class_name SpikeShieldEnemyDeath
extends LimboState

@export var parent: CharacterBody2D
@export var animation: AnimationPlayer

func _enter() -> void:
	animation.play("dead")
	parent.limit.erase(parent)

func _update(_delta):
	parent.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "dead":
		parent.queue_free()
