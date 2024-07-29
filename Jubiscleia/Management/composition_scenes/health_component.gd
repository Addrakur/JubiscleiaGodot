extends Node2D

@export var max_health: float
@export var destroy_after_dead: bool
@onready var parent: Node2D = get_parent()
var current_health: float = 100
var is_getting_hit: bool = false
var invulnerable: bool = false

var last_attack: String

func _ready() -> void:
	current_health = max_health

func _process(_delta):
	die()

func update_health(value: float, knockup: float, knockback: float, direction: float, last_attack_name: String) -> void:
	if last_attack_name != last_attack:
		last_attack = last_attack_name
		is_getting_hit = true
		current_health -= value
		
		parent.hit_state.knockup_force = knockup * parent.hit_state.knock_multi # Aplica a força do knockback
		parent.hit_state.knockback_force = knockback * parent.hit_state.knock_multi # Aplica a força do knockup
		parent.hit_state.direction = direction
		
		if parent.fsm.state == parent.hit_state: # Gambiarra que faz o alvo reiniciar o hit state
			parent.fsm.change_state(parent.hit_state)
		
		if parent.is_in_group("player"):
			parent.corruption_manager.time_penalty()
		
		print("tomou dano de " + last_attack_name)
	else:
		#print("nao tomou dano de " + last_attack_name)
		pass

func die() -> void:
	if current_health <= 0:
		parent.alive = false
