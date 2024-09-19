extends Node

#Scenes
var menu: String = "res://Management/menu.tscn"
var tutorial: String = "res://levels/loop_basico.tscn"
var level1: String = "res://levels/level_1.tscn"
var level2: String = "res://levels/level_2.tscn"
var level3: String = "res://levels/level_3.tscn"
var arena: String = "res://levels/arena.tscn"

#Objects
var projectile = preload("res://player/player_attack_projectile.tscn")
var spear_burst = preload("res://player/player_spear_burst.tscn")
var bee = preload("res://enemies/bee.tscn")
var fireball = preload("res://enemies/kitsune_fire.tscn")
var big_worm = preload("res://enemies/big_worm.tscn")
var kitsune = preload("res://enemies/kitsune.tscn")
var scorpion = preload("res://enemies/scorpion.tscn")
var spear_skeleton = preload("res://enemies/spear_skeleton.tscn")
var sword_skeleton = preload("res://enemies/sword_skeleton.tscn")
var snake = preload("res://enemies/snake.tscn")