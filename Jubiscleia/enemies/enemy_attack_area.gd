class_name EnemyAttackArea
extends AttackArea

func _physics_process(_delta):
	if body_ref != null:
		hit_func(body_ref)

func _on_body_entered(ref: Node2D) -> void:
	if not multi_hit:
		hit_func(ref)
	else:
		body_ref = ref
	
func _on_body_exited(body: Node2D) -> void:
	if body == body_ref:
		body_ref = null

func hit_func(body: Node2D):

	if body is Player and not body.health_component.invulnerable and body.alive:
		body.health_component.update_health(damage, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent)
	
	if can_destroy_on_hit_check(body):
		parent.can_destroy = true
