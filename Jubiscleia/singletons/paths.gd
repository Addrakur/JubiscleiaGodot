extends Node

#Scenes
var menu: String = "res://Management/menu.tscn"
var tutorial: String = "res://levels/loop_basico.tscn"
var tutorial_level_1: String = "res://levels/tutorial_level_1.tscn"
var tutorial_boss: String = "res://levels/tutorial_boss_level.tscn"
var level_map: String = "res://levels/level_map.tscn"
var earth_level_1: String = "res://levels/earth_level_1.tscn"
var earth_level_2: String = "res://levels/earth_level_2.tscn"
var earth_level_3: String = "res://levels/earth_level_3.tscn"
var earth_key_1_level_1: String = "res://levels/earth_key_1_level_1.tscn"
var arena: String = "res://levels/arena.tscn"

#Enemies
var bee = preload("res://enemies/bee.tscn")
var big_worm = preload("res://enemies/big_worm.tscn")
var kitsune = preload("res://enemies/kitsune.tscn")
var scorpion = preload("res://enemies/scorpion.tscn")
var spear_skeleton = preload("res://enemies/spear_skeleton.tscn")
var sword_skeleton = preload("res://enemies/sword_skeleton.tscn")
var snake = preload("res://enemies/snake.tscn")
var spike_shield_enemy = preload("res://enemies/spike_shield_enemy.tscn")
var aereal_suicide_enemy = preload("res://enemies/aereal_suicide_enemy.tscn")
var sniper_enemy = preload("res://enemies/sniper_enemy.tscn")
var rockrab = preload("res://enemies/rockrab.tscn")
var fire_reaper = preload("res://enemies/fire_reaper.tscn")
var stalac = preload("res://enemies/stalac.tscn")

#Objects
var projectile = preload("res://player/player_attack_projectile.tscn")
var spear_burst = preload("res://player/player_spear_burst.tscn")
var fireball = preload("res://enemies/kitsune_fire.tscn")
var sniper_enemy_projectile = preload("res://enemies/sniper_enemy_projectile.tscn")
var elemental_orb = preload("res://Management/elemental_orb.tscn")
var slow_timer = preload("res://Management/composition_scenes/slow_timer.tscn")
var air_damage_area = preload("res://player/air_area_damage.tscn")
var temp_life_bar = preload("res://Management/temp_life_bar.tscn")
var fire_dot = preload("res://player/fire_dot.tscn")
