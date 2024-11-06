class_name SniperEnemyProjectile
extends Node2D

var can_destroy: bool = false

var can_move: bool = false

var speed: float

var target_position: Vector2

var tween_duration: float

func _physics_process(_delta: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position,tween_duration)
	
	if can_destroy:
		tween.kill()
		self.queue_free()
