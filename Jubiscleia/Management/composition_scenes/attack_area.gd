class_name AttackArea
extends Area2D

@export var parent: Node
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float
@export var poise_damage: float
@export var attack_name: String

@export_group("Bools")
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false
@export var multi_hit: bool = false
@export var destroy_on_walls: bool = false

var body_ref: Node2D

func can_destroy_on_hit_check(body: Node) -> bool:
	if one_hit_destroy or body.is_in_group("terrain") and destroy_on_terrain:
		return true
	else:
		return false
