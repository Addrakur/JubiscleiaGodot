extends Node2D

@export_enum("big_worm","kitsune","scorpion","spear_skeleton","sword_skeleton","snake","spike_shield_enemy","aereal_suicide_enemy","sniper_enemy") var enemy: String

@export_group("Bools")
@export var has_starting_x: bool
@export var has_warp_area: bool
@export var has_set_direction: bool
@export var has_left_and_right_points: bool

@export_group("Refs")
@export var set_direction: float
@export var warp_area: Polygon2D
@export var starting_x: Marker2D
@export var limit: EnemyLimit
@export var spawn_point: Marker2D
@export var point_left: Marker2D
@export var point_right: Marker2D
@onready var sprite = $Sprite
@onready var animation = $Animation

var can_spawn: bool = false
var inside_area: bool = false

func _ready():
	animation.play(enemy)
	

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F and can_spawn and not animation.is_playing():
			can_spawn = false
			animation.play("cooldown")
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
	var enemy_inst = Paths.get(enemy).instantiate()
	enemy_inst.position = spawn_point.position
	limit.add_child(enemy_inst)
	limit.add(enemy_inst)
	enemy_inst.limit = limit
	if limit.player_inside_limit:
		enemy_inst.player_on_limit = true
	
	if has_starting_x:
		enemy_inst.starting_x = starting_x
	
	if has_warp_area:
		enemy_inst.warp_area = warp_area
	
	if has_set_direction:
		enemy_inst.direction = set_direction

	
	if has_left_and_right_points:
		enemy_inst.point_left = point_left
		enemy_inst.point_right = point_right
