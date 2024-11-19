class_name AerealSuicideEnemyAttack
extends LimboState

@export var parent: AerealSuicideEnemy
@export var animation: AnimationPlayer
@export var descent_speed_limit: float
@export var descent_start_speed: float

var start_descent: bool = false

func _enter():
	animation.play("prepare")
	parent.velocity.x = 0

func _update(_delta: float) -> void:
	if start_descent and parent.velocity.y < descent_speed_limit:
		parent.velocity.y = parent.velocity.y + parent.velocity.y * 0.05

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "prepare":
		parent.velocity.y = descent_start_speed
		start_descent = true
