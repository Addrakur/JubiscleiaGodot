extends Area2D

@onready var limit_area: CollisionPolygon2D = $LimitArea
@onready var enemy: CharacterBody2D = $Enemy
@export var limit_points: Array

func _ready() -> void:
	limit_area.polygon = limit_points


func on_body_entered(body):
	if body.is_in_group("player"):
		enemy.player_on_limit = true

func on_body_exited(body):
	if body.is_in_group("player"):
		enemy.player_on_limit = false
