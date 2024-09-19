extends Node

#Player Variables

var player_max_health: float = 100
var player_max_poise: float = 5
var player_poise_recover_time: float = 5
var player_knockback_mult: float = 1
var player_hit_recover_limit: float = 50

var player_coyote_time: float = 0.15

var player_run_speed: float = 200

var player_first_jump_height: float = 110
var player_first_jump_time_to_peak: float = 0.4
var player_first_jump_time_to_descend: float = 0.35
var player_first_jump_move_speed: float = 200

var player_double_jump_height: float = 40
var player_double_jump_time_to_peak: float = 0.4
var player_double_jump_move_speed: float = 200

var player_fall_terminal_velocity: float = 450
var player_fall_move_speed: float = 200

var player_dash_speed: float = 450
var player_dash_cd: float = 1

var player_wall_grab_gravity: float = 130
var player_wall_grab_out_force: float = 260
var player_wall_grab_min_wait_time: float = 0.08
var player_wall_grab_max_wait_time: float = 0.3

var player_combo_memory_time: float = 1
var player_hits_0_1: float = 15
var player_hits_1_2: float = 10
var player_hits_2_3: float = 10

var player_0_timer: float = 20
var player_1_timer: float = 15
var player_2_timer: float = 10
var player_3_timer: float = 10

#Spear Skeleton Variables

var spear_skeleton_max_health: float = 12
var spear_skeleton_max_poise: float = 6
var spear_skeleton_poise_recover_time: float = 2
var spear_skeleton_knockback_mult: float = 1
var spear_skeleton_hit_recover_limit: float = 20

var spear_skeleton_walk_speed: float = 30
var spear_skeleton_wander_limit: float = 20

var spear_skeleton_idle_time: float = 4

var spear_skeleton_run_speed: float = 100

var spear_skeleton_attack_cooldown: float = 3

var spear_skeleton_attack_damage: float = 10
var spear_skeleton_attack_knockback: float = 500
var spear_skeleton_attack_knockup: float = -50
var spear_skeleton_attack_poise_damage: float = 10

var spear_skeleton_contact_damage_bool: float = 1
var spear_skeleton_contact_damage: float = 2
var spear_skeleton_contact_knockback: float = 300
var spear_skeleton_contact_knockup: float = -100
var spear_skeleton_contact_poise_damage: float = 20

#Sword Skeleton Variables

var sword_skeleton_max_health: float = 10
var sword_skeleton_max_poise: float = 5
var sword_skeleton_poise_recover_time: float = 2
var sword_skeleton_knockback_mult: float = 1.5
var sword_skeleton_hit_recover_limit: float = 10

var sword_skeleton_walk_speed: float = 50
var sword_skeleton_wander_limit: float = 40

var sword_skeleton_idle_time: float = 3

var sword_skeleton_run_speed: float = 130

var sword_skeleton_attack_cooldown: float = 3

var sword_skeleton_attack_damage: float = 10
var sword_skeleton_attack_knockback: float = 300
var sword_skeleton_attack_knockup: float = 0
var sword_skeleton_attack_poise_damage: float = 5

var sword_skeleton_contact_damage_bool: float = 1
var sword_skeleton_contact_damage: float = 2
var sword_skeleton_contact_knockback: float = 300
var sword_skeleton_contact_knockup: float = -100
var sword_skeleton_contact_poise_damage: float = 20

var sword_skeleton_protect_duration: float = 3
var sword_skeleton_protect_cooldown: float = 4

#Kitsune Variables

var kitsune_max_health: float = 8
var kitsune_max_poise: float = 3
var kitsune_poise_recover_time: float = 5
var kitsune_knockback_mult: float = 2
var kitsune_hit_recover_limit: float = 10

var kitsune_walk_speed: float = 75

var kitsune_idle_time: float = 5

var kitsune_run_speed: float = 150
var kitsune_run_duration: float = 2
var kitsune_run_cooldown: float = 3

var kitsune_attack_cooldown: float = 3

var kitsune_attack_damage: float = 5
var kitsune_attack_knockback: float = 150
var kitsune_attack_knockup: float = -50
var kitsune_attack_poise_damage: float = 5
var kitsune_attack_speed: float = 150

var kitsune_contact_damage_bool: float = 1
var kitsune_contact_damage: float = 2
var kitsune_contact_knockback: float = 300
var kitsune_contact_knockup: float = -100
var kitsune_contact_poise_damage: float = 20

#Training Dummy

var dummy_max_health: float = 1000
var dummy_max_poise: float = 10
var dummy_poise_recover_time: float = 3
var dummy_knockback_mult: float = 1
var dummy_hit_recover_limit: float = 10
