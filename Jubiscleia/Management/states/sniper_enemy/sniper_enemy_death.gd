class_name SniperEnemyDeath
extends LimboState

@export var parent: CharacterBody2D

func _enter() -> void:
	parent.limit.erase(parent)
	parent.queue_free()
