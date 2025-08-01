class_name HealthComponent
extends Node2D

@export var max_health: float
@export var max_poise: float
@export var poise_recover_timer: float
@export var attack_timer: Timer
@export var max_temp_life: float
@export var starting_temp_life: float
@onready var parent: Node2D = get_parent()
var current_health: float = 100
var current_poise: float = 1000
var current_temp_life: float
var is_getting_hit: bool = false
var invulnerable: bool = false
@export var defending: bool = false
@export var left: bool

var last_attack: String

var orb_spawned: bool = false

func _ready() -> void:
	current_health = max_health
	current_poise = max_poise
	
	if parent is Player:
		max_health += SkillTree.bonus_life
		current_health = max_health
		print(max_health)

func _process(_delta):
	die()

func update_health(health_damage: float, knockup: float, knockback: float, direction: float, last_attack_name: String, poise_damage: float, attack_position: float, attacker: Node2D) -> void:
	if last_attack_name != last_attack:
		last_attack = last_attack_name
		if can_recieve_damage(attack_position):
			if current_temp_life > 0:
				current_temp_life -= health_damage
				parent.hit_modulate.play("hit")
			else:
				current_health -= health_damage
				current_poise -= poise_damage
				print("dano")
				
				if current_poise <= 0:
					parent.hit_state.knockup_force = knockup * parent.hit_state.knock_multi # Aplica a força do knockback
					parent.hit_state.knockback_force = knockback * parent.hit_state.knock_multi # Aplica a força do knockup
					parent.hit_state.direction = direction
				
					if parent.get("fsm") != null:
						parent.fsm.change_state(parent.hit_state)
					else:
						parent.hsm.dispatch("apply_knockback")
					
					current_poise = max_poise
					#if attack_timer != null:
						#attack_timer.stop()
				
				else:
					parent.hit_modulate.play("hit")
					
		else:
			parent.hit_modulate.play("defending")
			if attacker != null and attacker.is_in_group("player_object"):
				attacker.can_destroy = true
		

func die() -> void:
	if current_health <= 0:
		parent.alive = false
		if parent.is_in_group("enemy") and not orb_spawned and not parent.is_in_group("obstacle"):
			spawn_elemental_orb(parent.position, parent.element, parent.limit)
			orb_spawned = true

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

func spawn_elemental_orb(spawn_position: Vector2, element: String, limit: EnemyLimit):
	var orb = Paths.elemental_orb.instantiate()
	limit.add_child(orb)
	orb.position = spawn_position
	orb.element = element
	orb.set_animation()
