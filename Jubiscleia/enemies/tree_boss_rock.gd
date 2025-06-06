extends RigidBody2D

@export var throw_force: float

@onready var attack_area_collision: CollisionShape2D = $AttackArea/attack_area_collision
@onready var collision: CollisionShape2D = $collision

var can_destroy: bool = false
var direction: float

func _physics_process(_delta: float) -> void:
	var colliding_with: Array = get_colliding_bodies()
	for body in colliding_with:
		if body.is_in_group("enemy_wall"):
			can_destroy = true
		
	if can_destroy:
		queue_free()
	

func throw_rock():
	linear_velocity = Vector2(throw_force * direction,0)
	

func set_physics():
	attack_area_collision.disabled = false
	collision.disabled = false
	gravity_scale = 1
