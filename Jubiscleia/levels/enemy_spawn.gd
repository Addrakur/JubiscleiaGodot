extends Node2D

@export_enum("big_worm","kitsune","scorpion","skeleton","snake") var Enemy: String

@export_group("Bools")
@export var has_starting_x: bool
@export var has_warp_area: bool
@export var has_set_direction: bool

@export_group("Refs")
@export var warp_area: Polygon2D
@export var starting_x: Marker2D
@export var limit: Area2D

@onready var sprite = $Sprite
@onready var animation = $Animation

var can_spawn: bool = false
var inside_area: bool = false

var big_worm = preload("res://enemies/big_worm.tscn")
var kitsune = preload("res://enemies/kitsune.tscn")
var scorpion = preload("res://enemies/scorpion.tscn")
var skeleton = preload("res://enemies/spear_skeleton.tscn")
var snake = preload("res://enemies/snake.tscn")

func _ready():
	animation.play(Enemy)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F and can_spawn:
			can_spawn = false
			spawn_enemy()
		
		if event.is_released() and event.keycode == KEY_F and inside_area:
			can_spawn = true

func _on_area_entered(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		inside_area = true
		can_spawn = true

func _on_area_exited(body):
	if body.is_in_group("player") and not body.is_in_group("projectile"):
		inside_area = false
		can_spawn = false

func spawn_enemy():
	var enemy_inst = get(Enemy).instantiate()
	enemy_inst.position = starting_x.position
	limit.add_child(enemy_inst)
	limit.add(enemy_inst)
	enemy_inst.limit = limit
	
	if has_starting_x:
		enemy_inst.starting_x = starting_x
	
	if has_warp_area:
		enemy_inst.warp_area = limit.limit_polygon
	
	if has_set_direction:
		enemy_inst.direction = -1
