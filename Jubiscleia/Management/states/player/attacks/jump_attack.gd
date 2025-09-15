class_name PlayerJumpAttack
extends State

@export var player: Player
@export var animation: AnimationPlayer
@export var move_speed: float

var speed: float
var direction: float

var next_attack_sustain: int

var stop: bool = true

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	stop = true
	next_attack_sustain = player.next_attack
	player.combo_timer.stop()
	
	PlayerVariables.current_skill = PlayerVariables.next_skill
	animation.play(PlayerVariables.current_skill + "_jump", -1, PlayerVariables.attack_speed,false)
	PlayerVariables.current_attack = PlayerVariables.current_skill + "_jump"
	player.attack_area.current_element = PlayerVariables.get(PlayerVariables.current_skill + "_element")
	player.attack_area.attack_name = PlayerVariables.current_attack
	player.can_combo = false
	
	speed = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_speed")
	player.override_gravity = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_gravity")
	
	player.attack_area.damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_damage") * PlayerVariables.damage_mult
	player.attack_area.knockback_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_knockback")
	player.attack_area.knockup_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_knockup")
	player.attack_area.poise_damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_poise")
	
	player.velocity.x = 0
	
func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0
	PlayerVariables.my_knockup = false
	PlayerVariables.last_skill = PlayerVariables.current_skill
	PlayerVariables.player_attacking = false
	PlayerVariables.move = false
	PlayerVariables.current_skill = ""
	PlayerVariables.current_attack = ""
	PlayerVariables.can_move_during_attack = false
	player.can_flip = true
	stop = false
	player.can_dash = true
	player.camera_methods.weapon_shake_false()
	
	PlayerVariables.anim_finish = false
	
	player.next_attack = next_attack_sustain
	player.combo_timer.start()

func _physics_process(delta):
	if stop:
		player.velocity.y = player.velocity.y - player.velocity.y * 5 * delta
	
	if PlayerVariables.can_move_during_attack:
		player.velocity.x = player.direction * player.jump_state.speed
	
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	if PlayerVariables.anim_finish: #Sai do estado de ataque
		player.fsm.change_state(player.fall_state)
	
	if PlayerVariables.current_skill == "axe" and player.is_on_floor():
		_play_animation("axe_jump_wind_down")

func stop_false() -> void:
	stop = false

func my_knockup_true():
	PlayerVariables.my_knockup = true

func _play_animation(anim_name: String) -> void:
	animation.play(anim_name, -1, PlayerVariables.attack_speed, false)

func set_gravity_override(value: float):
	if value != 0:
		player.override_gravity = value
	else:
		player.override_gravity = PlayerVariables.get(str(PlayerVariables.current_skill) + "_jump_gravity")

func _set_velocity_y(value: float):
	player.velocity.y = value
