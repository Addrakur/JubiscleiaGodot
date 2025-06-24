class_name BossTree
extends CharacterBody2D

@export var health_component: HealthComponent
@export var attack_area: AttackArea
@export_enum("water","fire","earth","air") var element: String
@export var player: Player
@export var arena_right: Marker2D
@export var arena_left: Marker2D
@export var arena_middle: Marker2D
@export var seed_spawn_points: Node2D
@export var limit: Area2D
@export var fireball_horizontal_spawn_points: Array[Marker2D]
@export var fireball_vertical_spawn_points: Node2D

@onready var animation: AnimationPlayer = $animation
@onready var texture: Sprite2D = $texture
@onready var melee_detect_area: Area2D = $melee_detect_area
@onready var rock_position: Marker2D = $Path2D/PathFollow2D/rock_position
@onready var collision_polygon_2d: CollisionPolygon2D = $AttackArea/CollisionPolygon2D
@onready var path_2d: Path2D = $Path2D
@onready var hit_modulate: AnimationPlayer = $hit_modulate

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/idle
@onready var swipe_state: LimboState = $hsm/attack_swipe
@onready var rock_throw_state: LimboState = $hsm/attack_throw_rock
@onready var seed_rain_state: LimboState = $hsm/attack_seed_rain
@onready var change_fase_state: LimboState = $hsm/change_fase
@onready var run_state: LimboState = $hsm/run

@onready var player_ref: Player
var target: Node2D
var player_on_limit: bool = false
var can_attack_melee: bool = false
var on_left_limit: bool = false
var on_right_limit: bool = false
var is_moving: bool = false
var can_attack_ranged: bool = false
var can_rain_seed: bool = false
var alive: bool = true
var move: bool = false
var rock = preload("res://enemies/tree_boss_rock.tscn")
var boss_seed = preload("res://enemies/tree_boss_seed.tscn")
var fireball = preload("res://enemies/tree_boss_fireball.tscn")
var next_attack: String

var proj: Node2D
var preparing_rock: bool = false

var fase_1: bool = true

var speed: float = 1

var direction: float

func _ready() -> void:
	init_state_machine()
	player_ref = player

func _process(_delta: float) -> void:
	is_moving = true if velocity.x != 0 else false
	
	if position.x > arena_middle.position.x - 10 and position.x < arena_middle.position.x + 10:
		can_rain_seed = true
	else:
		can_rain_seed = false
	
	if target == arena_left and on_left_limit or target == arena_right and on_right_limit:
		can_attack_ranged = true
	else:
		can_attack_ranged = false
	
	if velocity.x > 0:
		right()
	elif velocity.x < 0:
		left()
	
	if preparing_rock:
		proj.position = rock_position.global_position
	
	if not alive:
		queue_free()
	
	if player_ref != null:
		fireball_vertical_spawn_points.global_position.x = player_ref.global_position.x

func _physics_process(_delta: float) -> void:
	move_and_slide()

func init_state_machine():
	hsm.add_transition(idle_state, swipe_state, &"idle_to_swipe")
	hsm.add_transition(idle_state, rock_throw_state, &"idle_to_throw")
	hsm.add_transition(idle_state, seed_rain_state, &"idle_to_seed")
	hsm.add_transition(idle_state, change_fase_state, &"idle_to_change_fase")
	hsm.add_transition(idle_state, run_state, &"idle_to_run")
	
	hsm.add_transition(swipe_state, idle_state, &"swipe_to_idle")
	
	hsm.add_transition(rock_throw_state, idle_state, &"throw_to_idle")
	hsm.add_transition(rock_throw_state, run_state, &"throw_to_run")
	
	hsm.add_transition(seed_rain_state, idle_state, &"seed_to_idle")
	
	hsm.add_transition(change_fase_state, idle_state, &"change_fase_to_idle")
	
	hsm.add_transition(run_state, swipe_state, &"run_to_swipe")
	hsm.add_transition(run_state, rock_throw_state, &"run_to_throw")
	hsm.add_transition(run_state, seed_rain_state, &"run_to_seed")
	
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)

func _on_melee_detect_area_body_entered(body: Node2D) -> void:
	if body is Player:
		can_attack_melee = true

func _on_melee_detect_area_body_exited(body: Node2D) -> void:
	if body is Player:
		can_attack_melee = false

func right():
	texture.flip_h = true
	melee_detect_area.scale.x = -1
	path_2d.scale.x = -1
	collision_polygon_2d.scale.x = -1

func left():
	texture.flip_h = false
	melee_detect_area.scale.x = 1
	path_2d.scale.x = 1
	collision_polygon_2d.scale.x = 1

func spawn_rock():
	proj = rock.instantiate()
	add_child(proj)
	set_preparing_rock(true)
	proj.position = rock_position.global_position
	proj.visible = true
	proj.direction = 1 if texture.flip_h else -1

func spawn_seed():
	var spawn_points = seed_spawn_points.get_children()
	for seed_spawn_point in spawn_points:
		proj = boss_seed.instantiate()
		add_child(proj)
		proj.position = seed_spawn_point.global_position + Vector2(randf_range(-10,10), randf_range(-10,10))
		proj.visible = true

func spawn_fireball_on_right_place(spawn_1: bool, spawn_2: bool, spawn_3: bool, spawn_4: bool, spawn_5: bool, spawn_6: bool, horizontal: bool):
	match horizontal:
		true:
			if spawn_1:
				spawn_fireball(fireball_horizontal_spawn_points[0].global_position, horizontal)
			if spawn_2:
				spawn_fireball(fireball_horizontal_spawn_points[1].global_position, horizontal)
			if spawn_3:
				spawn_fireball(fireball_horizontal_spawn_points[2].global_position, horizontal)
			if spawn_4:
				spawn_fireball(fireball_horizontal_spawn_points[3].global_position, horizontal)
			if spawn_5:
				spawn_fireball(fireball_horizontal_spawn_points[4].global_position, horizontal)
			if spawn_6:
				spawn_fireball(fireball_horizontal_spawn_points[5].global_position, horizontal)
		false:
			var spawn_points = fireball_vertical_spawn_points.get_children()
			for spawn_point in spawn_points:
				spawn_fireball(spawn_point.global_position, horizontal)

func spawn_fireball(spawn_position: Vector2, horizontal: bool):
	proj = fireball.instantiate()
	add_child(proj)
	proj.position = spawn_position
	proj.visible = true
	if horizontal:
		proj.horizontal = true
		proj.direction = 1 if texture.flip_h else -1
	else:
		proj.horizontal = false

func throw_rock():
	if proj != null:
		proj.throw_rock()

func set_physics():
	proj.set_physics()

func _on_right_area_body_entered(body: Node2D) -> void:
	if body is BossTree:
		on_right_limit = true

func _on_right_area_body_exited(body: Node2D) -> void:
	if body is BossTree:
		on_right_limit = false

func _on_left_area_body_entered(body: Node2D) -> void:
	if body is BossTree:
		on_left_limit = true

func _on_left_area_body_exited(body: Node2D) -> void:
	if body is BossTree:
		on_left_limit = false

func set_preparing_rock(value: bool):
	preparing_rock = value

func _on_hit_modulate_animation_finished(_anim_name):
	health_component.last_attack = ""
