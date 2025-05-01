extends RigidBody2D

func _ready() -> void:
	apply_impulse(Vector2(-1000,0), Vector2(position.x + 10,position.y))

func _physics_process(delta: float) -> void:
	var colliding_with: Array = get_colliding_bodies()
	for body in colliding_with:
		if body.is_in_group("enemy_wall"):
			queue_free()
