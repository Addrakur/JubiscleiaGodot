extends Node

var player_max_life: float = 10
var player_current_life: float
var corruption_level: float = 0
var hit_amount: float

var player_alive: bool = true
var player_attacking: bool = false

var current_skill: String
var last_skill: String
var skill_1: String = "sword" 
var skill_2: String = "axe"

var move: bool = false
var my_knockup: bool = false


var axe_1_damage: float = 3
var axe_1_knockback: float = 80
var axe_1_knockup: float = -20
var axe_1_speed: float = 400

var axe_2_damage: float = 4
var axe_2_knockback: float = 0
var axe_2_knockup: float = 0
var axe_2_speed: float = 400

var axe_3_damage: float = 6
var axe_3_knockback: float = 300
var axe_3_knockup: float = -150
var axe_3_speed: float = 400

var axe_jump_damage: float = 5
var axe_jump_knockback: float = 300
var axe_jump_knockup: float = -150


var sword_1_damage: float = 2
var sword_1_knockback: float = 0
var sword_1_knockup: float = 0
var sword_1_speed: float = 400

var sword_2_damage: float = 3
var sword_2_knockback: float = 0
var sword_2_knockup: float = 0
var sword_2_speed: float = -400

var sword_3_damage: float = 4
var sword_3_knockback: float = 0
var sword_3_knockup: float = 0
var sword_3_speed: float = 400

var sword_jump_damage: float = 2
var sword_jump_knockback: float = 0
var sword_jump_knockup: float = 0


var spear_1_damage: float = 3
var spear_1_knockback: float = 0
var spear_1_knockup: float = 0

var spear_2_damage: float = 4
var spear_2_knockback: float = 200
var spear_2_knockup: float = -100

var spear_3_damage: float = 5
var spear_3_knockback: float = 0
var spear_3_knockup: float = 0
var spear_3_speed: float = 400

var spear_jump_damage: float = 3
var spear_jump_knockback: float = 0
var spear_jump_knockup: float = 0
var spear_jump_my_knockup: float = -500
