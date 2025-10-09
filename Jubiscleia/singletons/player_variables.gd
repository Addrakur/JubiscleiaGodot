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
var player_parry: bool = false
var player_reduce_damage: bool = false
var gauntlet_reduced_damage: float = 0.3

var next_skill: String #Arma que vai ser usada no ataque que vai vir
var current_skill: String #Arma sendo usada no ataque atual
var current_attack: String #Ataque que está sendo usado atualmente
var last_skill: String #Ultima arma usada

var skill_1_weapon: String = "gauntlet"
var skill_1_element: String = "earth"
var skill_1_attack_1: int = 1
var skill_1_attack_2: int = 2

var skill_2_weapon: String = "sword"
var skill_2_element: String = "water"
var skill_2_attack_1: int = 1
var skill_2_attack_2: int = 2

var move: bool = false
var my_knockup: bool = false
var anim_finish: bool = false
var can_move_during_attack: bool = false
var can_attack: bool = true
var active: bool = true
var immune_to_poise_damage: bool = false

#Armas e ataques desbloqueados

var sword_water_unlocked: bool = true
var sword_water_attack_1: bool = true
var sword_water_attack_1_damage: float = 2
var sword_water_attack_1_knockback: float = 80
var sword_water_attack_1_poise: float = 3
var sword_water_attack_1_speed: float = 300 * (attack_speed - 0.2)
var sword_water_attack_1_element_amount: float = 3

var sword_water_attack_2: bool = true
var sword_water_attack_2_damage: float = 3
var sword_water_attack_2_knockback: float = 80
var sword_water_attack_2_poise: float = 3
var sword_water_attack_2_speed: float = 0
var sword_water_attack_2_element_amount: float = 3

var sword_water_attack_3: bool = false


var sword_water_attack_4: bool = false


var sword_water_attack_5: bool = false


var sword_water_attack_6: bool = false


# sword_water_finisher
var sword_water_finisher_damage: float = 0
var sword_water_finisher_knockback: float = 0
var sword_water_finisher_poise: float = 0
var sword_water_finisher_speed: float = 0
var sword_water_finisher_element_amount: float = 0
var sword_water_finisher_projectile_damage: float = 3
var sword_water_finisher_projectile_speed: float = 100
var sword_water_finisher_projectile_knockback: float = 100
var sword_water_finisher_projectile_poise: float = 3
var sword_water_finisher_location: Vector2 = Vector2 (0,0)
var sword_water_finisher_projectile_max_distance: float = 100
var sword_water_finisher_projectile_element_amount: float = 2
var sword_water_finisher_shake: float = 1
# sword_water_jump_attack
var sword_water_jump_attack_damage: float = 2
var sword_water_jump_attack_knockback: float = 50
var sword_water_jump_attack_poise: float = 5
var sword_water_jump_attack_speed: float = 0
var sword_water_jump_attack_gravity: float = 0
var sword_water_jump_attack_element_amount: float = 3

var sword_earth_unlocked: bool = false


var axe_fire_unlocked: bool = true
var axe_fire_attack_1: bool = true
var axe_fire_attack_1_damage: float = 3
var axe_fire_attack_1_knockback: float = 200
var axe_fire_attack_1_poise: float = 5
var axe_fire_attack_1_speed: float = 0
var axe_fire_attack_1_element_amount: float = 5
var axe_fire_attack_1_shake: float = 1

var axe_fire_attack_2: bool = true
var axe_fire_attack_2_damage: float = 4
var axe_fire_attack_2_knockback: float = 200
var axe_fire_attack_2_poise: float = 5
var axe_fire_attack_2_speed: float = 800
var axe_fire_attack_2_element_amount: float = 5

var axe_fire_attack_3: bool = false
var axe_fire_attack_4: bool = false
var axe_fire_attack_5: bool = false
var axe_fire_attack_6: bool = false

# axe_fire_finisher
var axe_fire_finisher_damage: float = 5
var axe_fire_finisher_knockback: float = 250
var axe_fire_finisher_poise: float = 10
var axe_fire_finisher_speed: float = 0
var axe_fire_finisher_element_amount: float = 5
var axe_fire_finisher_shake: float = 1.5
#axe_fire_jump_attack
var axe_fire_jump_attack_damage: float = 3
var axe_fire_jump_attack_knockback: float = 200
var axe_fire_jump_attack_poise: float = 10
var axe_fire_jump_attack_speed: float = 0
var axe_fire_jump_attack_gravity: float = 1000
var axe_fire_jump_attack_element_amount: float = 5
var axe_fire_jump_attack_shake: float = 3

var gauntlet_earth_unlocked: bool = true
var gauntlet_earth_attack_1: bool = true
var gauntlet_earth_attack_1_damage: float = 2
var gauntlet_earth_attack_1_knockback: float = 300
var gauntlet_earth_attack_1_poise: float = 4
var gauntlet_earth_attack_1_speed: float = 0
var gauntlet_earth_attack_1_element_amount: float = 2

var gauntlet_earth_attack_2: bool = true
var gauntlet_earth_attack_2_damage: float = 2
var gauntlet_earth_attack_2_knockback: float = 300
var gauntlet_earth_attack_2_poise: float = 4
var gauntlet_earth_attack_2_speed: float = 0
var gauntlet_earth_attack_2_element_amount: float = 2

var gauntlet_earth_attack_3: bool = true
var gauntlet_earth_attack_4: bool = true
var gauntlet_earth_attack_5: bool = true
var gauntlet_earth_attack_6: bool = true

# gauntlet_earth_finisher
var gauntlet_earth_finisher_damage: float = 0
var gauntlet_earth_finisher_knockback: float = 0
var gauntlet_earth_finisher_poise: float = 0
var gauntlet_earth_finisher_speed: float = 0
var gauntlet_earth_finisher_element_amount: float = 0
var gauntlet_earth_finisher_projectile_damage: float = 2
var gauntlet_earth_finisher_projectile_speed: float = 200
var gauntlet_earth_finisher_projectile_knockback: float = 200
var gauntlet_earth_finisher_projectile_poise: float = 20
var gauntlet_earth_finisher_location: Vector2 = Vector2 (0,0)
var gauntlet_earth_finisher_projectile_max_distance: float = 100
var gauntlet_earth_finisher_projectile_element_amount: float = 2
var gauntlet_earth_finisher_shake: float = 1

func toggle_active_player(t_or_f: bool):
	active = t_or_f
