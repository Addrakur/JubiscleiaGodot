extends Node2D

@export var max_health: float
@export var max_poise: float
@export var poise_recovery_timer: float
@export var destroy_after_dead: bool
@export var attack_timer: Timer
@onready var parent: Node2D = get_parent()
var current_health: float = 100
var current_poise: float = 1000
var is_getting_hit: bool = false
var invulnerable: bool = false
var defending: bool = false

var last_attack: String

func _ready() -> void:
	current_health = max_health
	current_poise = max_poise

func _process(_delta):
	die()

func update_health(health_damage: float, knockup: float, knockback: float, direction: float, last_attack_name: String, poise_damage: float) -> void:
	if last_attack_name != last_attack:
		last_attack = last_attack_name
		if not defending:
			current_health -= health_damage
			current_poise -= poise_damage
		
		if current_poise <= 0:
			parent.hit_state.knockup_force = knockup * parent.hit_state.knock_multi # Aplica a força do knockback
			parent.hit_state.knockback_force = knockback * parent.hit_state.knock_multi # Aplica a força do knockup
			parent.hit_state.direction = direction
		
			#if parent.fsm.state == parent.hit_state: # Gambiarra que faz o alvo reiniciar o hit state
			parent.fsm.change_state(parent.hit_state)
			current_poise = max_poise
			if attack_timer != null:
				attack_timer.stop()
		else:
			if not defending:
				parent.hit_modulate.play("hit")
				parent.poise_timer.start(poise_recovery_timer)
			else:
				parent.hit_modulate.play("defending")
		
		if parent.is_in_group("player"):
			parent.corruption_manager.time_penalty()
		
		#print("tomou dano de " + last_attack_name)
	else:
		#print("nao tomou dano de " + last_attack_name)
		pass

func die() -> void:
	if current_health <= 0:
		parent.alive = false
