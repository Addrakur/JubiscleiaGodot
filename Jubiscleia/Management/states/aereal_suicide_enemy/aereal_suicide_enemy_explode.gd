class_name AerealSuicideEnemyExplode
extends LimboState

@export var parent: AerealSuicideEnemy
@export var animation: AnimationPlayer

func _enter():
	parent.velocity.x = 0
	animation.play("explode")
