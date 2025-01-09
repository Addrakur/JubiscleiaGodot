extends Node2D

@export var damage: float

var enemies_in_range: Array[CharacterBody2D]

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemies_in_range.append(body)

func _on_timer_timeout() -> void:
	for enemy in enemies_in_range:
		if enemy != null:
			enemy.health_component.update_health(damage, 0, 0, 0, "air_area_damage", 0, GameSettings.player.position.x, GameSettings.player)
	queue_free()
