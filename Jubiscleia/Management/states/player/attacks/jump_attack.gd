class_name PlayerJumpAttack
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var move_speed: float
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
	#player.can_dash = false
	next_attack_sustain = player.next_attack
	PlayerVariables.anim_finish = false
	
	PlayerVariables.last_skill = PlayerVariables.current_skill
	animation.play(PlayerVariables.current_skill + "_jump_" + str(PlayerVariables.corruption_level))
	PlayerVariables.current_attack = PlayerVariables.current_skill + "_jump_" + str(PlayerVariables.corruption_level)
	player.attack_area.attack_name = PlayerVariables.current_attack
	player.can_combo = false
	
	speed = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_speed")
	player.override_gravity = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_gravity")
	
	player.attack_area.damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_damage")
	player.attack_area.knockback_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_knockback")
	player.attack_area.knockup_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_knockup")
	player.attack_area.poise_damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_" + str(PlayerVariables.corruption_level) + "_poise")
	
	player.velocity.x = 0
	
	match PlayerVariables.current_skill:
		"spear":
			PlayerVariables.my_knockup = true
			PlayerVariables.can_move_during_attack = true
	
	PlayerVariables.current_skill = ""

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0
	PlayerVariables.my_knockup = false
	PlayerVariables.last_skill = ""
	PlayerVariables.player_attacking = false
	PlayerVariables.move = false
	PlayerVariables.current_attack = ""
	PlayerVariables.can_move_during_attack = false
	#attack_area.disabled = true
	stop = false
	player.can_dash = true
	
	PlayerVariables.anim_finish = false
	
	player.next_attack = next_attack_sustain
	player.combo_timer.start()

func _physics_process(_delta):
	if stop:
		player.velocity.y = player.velocity.y - player.velocity.y * 0.05
	
	if PlayerVariables.can_move_during_attack:
		player.velocity.x = player.direction * player.jump_state.speed
	
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	if PlayerVariables.anim_finish: #Sai do estado de ataque
		get_out_of_state()
	
	if PlayerVariables.last_skill == "axe" and player.is_on_floor():
		_play_animation("axe_jump_wind_down_" + str(PlayerVariables.corruption_level))

func stop_false() -> void:
	stop = false

func my_knockup_true():
	PlayerVariables.my_knockup = true

func _play_animation(anim_name: String) -> void:
	animation.play(anim_name)

func set_gravity_override(value: float):
	if value != 0:
		player.override_gravity = value
	else:
		player.override_gravity = PlayerVariables.get(str(PlayerVariables.last_skill) + "_jump_gravity")

func _set_velocity_y(value: float):
	player.velocity.y = value

func get_out_of_state():
	player.fsm.change_state(player.fall_state)
