class_name AerealSuicideEnemyAttack
extends LimboState

@export var parent: AerealSuicideEnemy
@export var timer: Timer
@export var descent_speed_limit: float

var start_descent: bool = false

func _enter():
	parent.velocity.x = 0
	parent.velocity.y = 30
	start_descent = true
	#timer.start()

func _update(_delta: float) -> void:
	if start_descent and parent.velocity.y > descent_speed_limit:
		parent.velocity.y = parent.velocity.y + parent.velocity.y * 0.05

func _on_timer_timeout() -> void:
	parent.velocity.y = 30
	start_descent = true
