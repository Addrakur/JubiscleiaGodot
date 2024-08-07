extends Node

@onready var player: CharacterBody2D
var player_max_life: float = 10
var player_current_life: float
var corruption_level: float = 0
var hit_amount: float

var player_alive: bool = true
var player_attacking: bool = false

var current_skill: String
var current_attack: String
var last_skill: String
var skill_1: String = "sword" 
var skill_2: String = "axe"

var move: bool = false
var my_knockup: bool = false
var anim_finish: bool = false
var can_move_during_attack: bool = false

var axe_1_speed: float = 0
var axe_2_speed: float = 600
var axe_3_speed: float = 0
var axe_jump_speed: float = 0
var axe_jump_gravity: float = 1000

var axe_0_1_damage: float = 3
var axe_0_1_knockback: float = 100
var axe_0_1_knockup: float = 0

var axe_0_2_damage: float = 4
var axe_0_2_knockback: float = 50
var axe_0_2_knockup: float = 0

var axe_0_3_damage: float = 6
var axe_0_3_knockback: float = 300
var axe_0_3_knockup: float = 0

var axe_1_1_damage: float = 4
var axe_1_1_knockback: float = 100
var axe_1_1_knockup: float = 0

var axe_1_2_damage: float = 6
var axe_1_2_knockback: float = 50
var axe_1_2_knockup: float = 0

var axe_1_3_damage: float = 8
var axe_1_3_knockback: float = 350
var axe_1_3_knockup: float = 0

var axe_2_1_damage: float = 5
var axe_2_1_knockback: float = 100
var axe_2_1_knockup: float = 0

var axe_2_2_damage: float = 8
var axe_2_2_knockback: float = 50
var axe_2_2_knockup: float = 0

var axe_2_3_damage: float = 10
var axe_2_3_knockback: float = 400
var axe_2_3_knockup: float = 0

var axe_3_1_damage: float = 6
var axe_3_1_knockback: float = 100
var axe_3_1_knockup: float = 0

var axe_3_2_damage: float = 10
var axe_3_2_knockback: float = 50
var axe_3_2_knockup: float = 0

var axe_3_3_damage: float = 12
var axe_3_3_knockback: float = 500
var axe_3_3_knockup: float = 0

var axe_jump_0_damage: float = 4
var axe_jump_0_knockback: float = 200
var axe_jump_0_knockup: float = 0


var sword_1_speed: float = 300
var sword_2_speed: float = 0
var sword_3_speed: float = 0
var sword_jump_speed: float = 0
var sword_jump_gravity: float = 0

var sword_0_1_damage: float = 3
var sword_0_1_knockback: float = 0
var sword_0_1_knockup: float = 0

var sword_0_2_damage: float = 3
var sword_0_2_knockback: float = 0
var sword_0_2_knockup: float = 0

var sword_0_3_damage: float = 0
var sword_0_3_knockback: float = 50
var sword_0_3_knockup: float = 0
var sword_0_3_projectile_damage: float = 2
var sword_0_3_projectile_speed: float = 100
var sword_0_3_projectile_knockback: float = 50
var sword_0_3_location: Vector2 = Vector2 (0,14)

var sword_1_1_damage: float = 4
var sword_1_1_knockback: float = 0
var sword_1_1_knockup: float = 0

var sword_1_2_damage: float = 4
var sword_1_2_knockback: float = 0
var sword_1_2_knockup: float = 0

var sword_1_3_damage: float = 0
var sword_1_3_knockback: float = 50
var sword_1_3_knockup: float = 0
var sword_1_3_projectile_damage: float = 3
var sword_1_3_projectile_speed: float = 125
var sword_1_3_projectile_knockback: float = 50
var sword_1_3_location: Vector2 = Vector2 (0,14)

var sword_2_1_damage: float = 5
var sword_2_1_knockback: float = 0
var sword_2_1_knockup: float = 0

var sword_2_2_damage: float = 5
var sword_2_2_knockback: float = 0
var sword_2_2_knockup: float = 0

var sword_2_3_damage: float = 0
var sword_2_3_knockback: float = 100
var sword_2_3_knockup: float = 0
var sword_2_3_projectile_damage: float = 4
var sword_2_3_projectile_speed: float = 150
var sword_2_3_projectile_knockback: float = 50
var sword_2_3_location: Vector2 = Vector2 (0,14)

var sword_3_1_damage: float = 6
var sword_3_1_knockback: float = 0
var sword_3_1_knockup: float = 0

var sword_3_2_damage: float = 6
var sword_3_2_knockback: float = 0
var sword_3_2_knockup: float = 0

var sword_3_3_damage: float = 0
var sword_3_3_knockback: float = 100
var sword_3_3_knockup: float = 0
var sword_3_3_projectile_damage: float = 5
var sword_3_3_projectile_speed: float = 175
var sword_3_3_projectile_knockback: float = 50
var sword_3_3_location: Vector2 = Vector2 (0,14)

var sword_jump_0_damage: float = 2
var sword_jump_0_knockback: float = 0
var sword_jump_0_knockup: float = 0


var spear_1_speed: float = 0
var spear_2_speed: float = -300
var spear_3_speed: float = 0
var spear_jump_speed: float = 0
var spear_jump_gravity: float = 0
var spear_jump_my_knockup: float = -500

var spear_0_1_damage: float = 2
var spear_0_1_knockback: float = 0
var spear_0_1_knockup: float = 0

var spear_0_2_damage: float = 2
var spear_0_2_knockback: float = 0
var spear_0_2_knockup: float = 0
var spear_0_2_burst_damage: float = 0
var spear_0_2_burst_knockback: float = 0
var spear_0_2_location: Vector2 = Vector2 (8,9)

var spear_0_3_damage: float = 0
var spear_0_3_knockback: float = 0
var spear_0_3_knockup: float = 0
var spear_0_3_projectile_damage: float = 3
var spear_0_3_projectile_speed: float = 250
var spear_0_3_projectile_knockback: float = 0
var spear_0_3_location: Vector2 = Vector2 (9,-6)

var spear_1_1_damage: float = 3
var spear_1_1_knockback: float = 0
var spear_1_1_knockup: float = 0

var spear_1_2_damage: float = 3
var spear_1_2_knockback: float = 0
var spear_1_2_knockup: float = 0
var spear_1_2_burst_damage: float = 0
var spear_1_2_burst_knockback: float = 0
var spear_1_2_location: Vector2 = Vector2 (4,10)

var spear_1_3_damage: float = 0
var spear_1_3_knockback: float = 0
var spear_1_3_knockup: float = 0
var spear_1_3_projectile_damage: float = 4
var spear_1_3_projectile_speed: float = 250
var spear_1_3_projectile_knockback: float = 0
var spear_1_3_location: Vector2 = Vector2 (9,-6)

var spear_2_1_damage: float = 4
var spear_2_1_knockback: float = 0
var spear_2_1_knockup: float = 0

var spear_2_2_damage: float = 4
var spear_2_2_knockback: float = 0
var spear_2_2_knockup: float = 0
var spear_2_2_burst_damage: float = 0
var spear_2_2_burst_knockback: float = 0
var spear_2_2_location: Vector2 = Vector2 (5,10)

var spear_2_3_damage: float = 0
var spear_2_3_knockback: float = 0
var spear_2_3_knockup: float = 0
var spear_2_3_projectile_damage: float = 5
var spear_2_3_projectile_speed: float = 250
var spear_2_3_projectile_knockback: float = 0
var spear_2_3_location: Vector2 = Vector2 (9,-6)

var spear_3_1_damage: float = 5
var spear_3_1_knockback: float = 0
var spear_3_1_knockup: float = 0

var spear_3_2_damage: float = 5
var spear_3_2_knockback: float = 0
var spear_3_2_knockup: float = 0
var spear_3_2_burst_damage: float = 0
var spear_3_2_burst_knockback: float = 0
var spear_3_2_location: Vector2 = Vector2 (4,10)

var spear_3_3_damage: float = 0
var spear_3_3_knockback: float = 0
var spear_3_3_knockup: float = 0
var spear_3_3_projectile_damage: float = 7
var spear_3_3_projectile_speed: float = 250
var spear_3_3_projectile_knockback: float = 0
var spear_3_3_location: Vector2 = Vector2 (9,-6)

var spear_jump_0_damage: float = 2
var spear_jump_0_knockback: float = 0
var spear_jump_0_knockup: float = 0
