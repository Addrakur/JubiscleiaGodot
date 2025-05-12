extends RigidBody2D

var can_destroy: bool = false

func _physics_process(_delta: float) -> void:
	if can_destroy:
		queue_free()
