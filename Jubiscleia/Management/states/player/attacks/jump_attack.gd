class_name PlayerJumpAttack
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var move_speed: float
var damage: float
var knockback_force: float
var knockup_force: float
@onready var attack_area = $"../../AttackArea/AttackArea"

var speed: float
var direction: float

var next_attack_sustain: float

var stop: bool = true

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	stop = true
	player.can_dash = false
	next_attack_sustain = player.next_attack
	PlayerVariables.anim_finish = false
	
	PlayerVariables.last_skill = PlayerVariables.current_skill
	animation.play(PlayerVariables.current_skill + "_jump_" + str(PlayerVariables.corruption_level))
	PlayerVariables.current_attack = PlayerVariables.current_skill + "_jump_" + str(PlayerVariables.corruption_level)
	player.can_combo = false
	
	speed = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_speed")
	damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_damage")
	knockback_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_knockback")
	knockup_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_knockup")
	player.override_gravity = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_gravity")
	
	player.attack_area.damage = damage
	player.attack_area.knockback_force = knockback_force
	player.attack_area.knockup_force = knockup_force
	
	match PlayerVariables.current_skill:
		"axe":
			player.velocity.x = 0
		"sword":
			player.velocity.x = 0
	
	PlayerVariables.current_skill = ""

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0
	PlayerVariables.my_knockup = false
	PlayerVariables.last_skill = ""
	PlayerVariables.player_attacking = false
	PlayerVariables.move = false
	PlayerVariables.current_attack = ""
	attack_area.disabled = true
	stop = false
	
	PlayerVariables.anim_finish = false
	
	player.next_attack = next_attack_sustain
	player.combo_timer.start()

func _physics_process(_delta):
	if stop:
		player.velocity.y = player.velocity.y - player.velocity.y * 0.05
	
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	if PlayerVariables.anim_finish: #Sai do estado de ataque
		player.can_dash = true
		player.fsm.change_state(player.idle_state)
	
	if PlayerVariables.last_skill == "axe" and player.is_on_floor():
		_play_animation("axe_jump_wind_down_" + str(PlayerVariables.corruption_level))

func _on_animation_finished(anim):
	pass

func stop_false() -> void:
	stop = false

func _play_animation(anim_name: String) -> void:
	animation.play(anim_name)

func set_gravity_override(value: float):
	if value != 0:
		player.override_gravity = value
	else:
		player.override_gravity = PlayerVariables.get(str(PlayerVariables.last_skill) + "_jump_gravity")

func _set_velocity_y(value: float):
	player.velocity.y = value
