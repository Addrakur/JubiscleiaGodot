class_name HealthComponent
extends Node2D

@export var has_parameter_slider: bool
var true_max_health: float = 1000
var true_max_poise: float = 1000
var true_poise_recover_time: float
@export var variable_name: String
@export var max_health: float
@export var max_poise: float
@export var poise_recover_timer: float
@export var destroy_after_dead: bool
@export var attack_timer: Timer
@onready var parent: Node2D = get_parent()
var current_health: float = 100
var current_poise: float = 1000
var is_getting_hit: bool = false
var invulnerable: bool = false
@export var defending: bool = false
@export var left: bool

var last_attack: String

func _ready() -> void:
	if not has_parameter_slider:
		current_health = max_health
		current_poise = max_poise
	else:
		true_max_health = Parameters.get(variable_name + "_max_health")
		true_max_poise = Parameters.get(variable_name + "_max_poise")
		true_poise_recover_time = Parameters.get(variable_name + "_poise_recover_time")
		current_health = true_max_health
		current_poise = true_max_poise
	

func _process(_delta):
	die()

func update_health(health_damage: float, knockup: float, knockback: float, direction: float, last_attack_name: String, poise_damage: float, attack_position: float, attacker: Node2D) -> void:
	if last_attack_name != last_attack:
		last_attack = last_attack_name
		if can_recieve_damage(attack_position):
			current_health -= health_damage
			current_poise -= poise_damage
			
			if current_poise <= 0:
				parent.hit_state.knockup_force = knockup * parent.hit_state.knock_multi # Aplica a força do knockback
				parent.hit_state.knockback_force = knockback * parent.hit_state.knock_multi # Aplica a força do knockup
				parent.hit_state.direction = direction
			
				if parent.get("fsm") != null:
					parent.fsm.change_state(parent.hit_state)
				else:
					parent.hsm.dispatch("apply_knockback")
				
				current_poise = max_poise if not has_parameter_slider else true_max_poise # Arrumar depois
				if attack_timer != null:
					attack_timer.stop()
			
			else:
				parent.hit_modulate.play("hit")
				
		else:
			parent.hit_modulate.play("defending")
			if attacker != null and attacker.is_in_group("player_object"):
				attacker.can_destroy = true
		
		#if parent.is_in_group("player"):
			#parent.corruption_manager.time_penalty()
		
		#print("tomou dano de " + last_attack_name)
	else:
		#print("nao tomou dano de " + last_attack_name)
		pass

func die() -> void:
	if current_health <= 0:
		parent.alive = false

func can_recieve_damage(attack_position: float) -> bool:
	if defending:
		if left:
			if parent.position.x > attack_position and parent.texture.flip_h or parent.position.x < attack_position and not parent.texture.flip_h:
				return true
			else:
				return false
		else:
			if parent.position.x > attack_position and not parent.texture.flip_h or parent.position.x < attack_position and parent.texture.flip_h:
				return true
			else:
				return false
	else:
		return true
