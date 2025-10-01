extends Node

@onready var player: Player
var player_max_life: float = 10
var player_current_life: float
var attack_speed: float = 1.2
var damage_mult: float = 1

var fire_stack_count: float = 0
var water_stack_count: float = 0
var air_stack_count: float = 0
var earth_stack_count: float = 0

var element_extra_damage: float = 1.2
var element_extra_stack: float = 1.5

var element_reduced_damage: float = 0.9
var element_reduced_stack: float = 0.75

var fire_dot_damage: float = 3

var elemental_rupture: String = ""

var player_alive: bool = true
var player_attacking: bool = false

var next_skill: String #Arma que vai ser usada no ataque que vai vir
var current_skill: String #Arma sendo usada no ataque atual
var current_attack: String #Ataque que está sendo usado atualmente
var last_skill: String #Ultima arma usada

var skill_1: String = "none"
var skill_1_weapon: String = "none"
var skill_1_element: String = "none"
var skill_1_attack_1: int = 0
var skill_1_attack_2: int = 0
var skill_1_finisher: int = 0

var skill_2: String = "none"
var skill_2_weapon: String = "none"
var skill_2_element: String = "none"
var skill_2_attack_1: int = 0
var skill_2_attack_2: int = 0
var skill_2_finisher: int = 0

var move: bool = false
var my_knockup: bool = false
var anim_finish: bool = false
var can_move_during_attack: bool = false
var can_attack: bool = true
var active: bool = true

#Armas e ataques desbloqueados

var sword_fire_unlocked: bool = false

var sword_air_unlocked: bool = false

var sword_water_unlocked: bool = true
var sword_water_attack_1: bool = true
var sword_water_attack_2: bool = true
var sword_water_attack_3: bool = false
var sword_water_attack_4: bool = false
var sword_water_attack_5: bool = false
var sword_water_attack_6: bool = false

var sword_water_finisher_1: bool = true
var sword_water_finisher_2: bool = false
var sword_water_finisher_3: bool = false

var sword_earth_unlocked: bool = false


var axe_fire_unlocked: bool = true
var axe_fire_attack_1: bool = true
var axe_fire_attack_2: bool = true
var axe_fire_attack_3: bool = false
var axe_fire_attack_4: bool = false
var axe_fire_attack_5: bool = false
var axe_fire_attack_6: bool = false

var axe_fire_finisher_1: bool = true
var axe_fire_finisher_2: bool = false
var axe_fire_finisher_3: bool = false

var axe_air_unlocked: bool = false
var axe_water_unlocked: bool = false
var axe_earth_unlocked: bool = false


var shield_fire_unlocked: bool = false
var shield_air_unlocked: bool = false
var shield_water_unlocked: bool = false
var shield_earth_unlocked: bool = false


var range_fire_unlocked: bool = false
var range_air_unlocked: bool = false
var range_water_unlocked: bool = false
var range_earth_unlocked: bool = false

#Variaveis dos ataques

var axe_1_speed: float = 0
var axe_2_speed: float = 800
var axe_3_speed: float = 0
var axe_jump_speed: float = 0
var axe_jump_gravity: float = 1000
var axe_element: String = "fire"
var axe_element_amount: float = 5
var axe_unlocked: bool = true

var axe_1_damage: float = 3
var axe_1_knockback: float = 200
var axe_1_poise: float = 5
var axe_1_shake: float = 1

var axe_2_damage: float = 4
var axe_2_knockback: float = 200
var axe_2_poise: float = 5

var axe_3_damage: float = 5
var axe_3_knockback: float = 250
var axe_3_poise: float = 10
var axe_3_shake: float = 1.5

var axe_jump_damage: float = 3
var axe_jump_knockback: float = 200
var axe_jump_poise: float = 10
var axe_jump_shake: float = 3


var sword_1_speed: float = 300 * (attack_speed - 0.2)
var sword_2_speed: float = 0
var sword_3_speed: float = 0
var sword_jump_speed: float = 0
var sword_jump_gravity: float = 0
var sword_element: String = "water"
var sword_element_amount: float = 3
var sword_unlocked: bool = true

var sword_1_damage: float = 2
var sword_1_knockback: float = 80
var sword_1_poise: float = 3

var sword_2_damage: float = 3
var sword_2_knockback: float = 80
var sword_2_poise: float = 3

var sword_3_damage: float = 0
var sword_3_knockback: float = 0
var sword_3_projectile_damage: float = 3
var sword_3_projectile_speed: float = 100
var sword_3_projectile_knockback: float = 100
var sword_3_projectile_poise: float = 3
var sword_3_location: Vector2 = Vector2 (0,0)
var sword_3_projectile_max_distance: float = 100
var sword_3_poise: float = 0
var sword_3_shake: float = 1

var sword_jump_damage: float = 2
var sword_jump_knockback: float = 50
var sword_jump_poise: float = 5


var spear_1_speed: float = 0
var spear_2_speed: float = 0
var spear_3_speed: float = 0
var spear_jump_speed: float = 0
var spear_jump_gravity: float = 0
var spear_jump_my_knockup: float = -500
var spear_element: String = "air"
var spear_element_amount: float = 3
var spear_unlocked: bool = false

var spear_1_damage: float = 2
var spear_1_knockback: float = 70
var spear_1_poise: float = 3

var spear_2_damage: float = 2
var spear_2_knockback: float = 50
var spear_2_poise: float = 3

var spear_3_damage: float = 0
var spear_3_knockback: float = 0
var spear_3_projectile_damage: float = 3
var spear_3_projectile_speed: float = 250
var spear_3_projectile_knockback: float = 30
var spear_3_projectile_poise: float = 5
var spear_3_projectile_max_distance: float = 240
var spear_3_location: Vector2 = Vector2 (9,-20)
var spear_3_poise: float = 0

var spear_jump_damage: float = 2
var spear_jump_knockback: float = 0
var spear_jump_poise: float = 5

func toggle_active_player(t_or_f: bool):
	active = t_or_f

func set_skill_1(new_skill: String):
	if not get(new_skill + "_unlocked"):
		return
	
	if skill_2 == new_skill:
		if new_skill == "sword":
			skill_2 = "axe"
		else:
			skill_2 = "sword"
	
	skill_1 = new_skill
	

func set_skill_2(new_skill: String):
	if not get(new_skill + "_unlocked"):
		return
	
	if skill_1 == new_skill:
		if new_skill == "sword":
			skill_1 = "axe"
		else:
			skill_1 = "sword"
	
	skill_2 = new_skill
	
