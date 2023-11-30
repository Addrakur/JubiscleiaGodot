extends Area2D

@onready var limit_area: CollisionPolygon2D = $LimitArea
@export var enemy: CharacterBody2D
@export var limit_points: Array

func _ready() -> void:
	limit_area.polygon = limit_points

func on_body_entered(body):
	if body.is_in_group("player") && enemy != null:
		enemy.player_on_limit = true

func on_body_exited(body):
	if body.is_in_group("player") && enemy != null:
		enemy.player_on_limit = false
