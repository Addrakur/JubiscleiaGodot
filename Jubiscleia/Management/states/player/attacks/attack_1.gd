class_name PlayerAttack1
extends State

@export var player: Player
@export var animation: AnimationPlayer

var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	PlayerVariables.current_skill = PlayerVariables.next_skill
	PlayerVariables.next_skill = ""
	player.attack_area.current_element = PlayerVariables.get("skill_" + PlayerVariables.current_skill + "_element")
	player.next_attack = 2
	player.attack_number.text = "2"
	player.can_combo = false
	
	player.combo_timer.stop()
	PlayerVariables.current_attack = PlayerVariables.get("skill_" + PlayerVariables.current_skill + "_weapon") + "_" + PlayerVariables.get("skill_" + PlayerVariables.current_skill + "_element") + "_attack_" + str(PlayerVariables.get("skill_" + PlayerVariables.current_skill + "_attack_1"))
	animation.play(PlayerVariables.current_attack,-1,PlayerVariables.attack_speed,false)
	player.attack_area.attack_name = PlayerVariables.current_attack

	speed = PlayerVariables.get(PlayerVariables.current_attack + "_speed")
	if speed != 0:
		player.set_collision_mask_value(2,true)
	
	player.attack_area.damage = PlayerVariables.get(PlayerVariables.current_attack + "_damage") * PlayerVariables.damage_mult
	player.attack_area.knockback_force = PlayerVariables.get(PlayerVariables.current_attack + "_knockback")
	player.attack_area.poise_damage = PlayerVariables.get(PlayerVariables.current_attack + "_poise")

func exit_state() -> void:
	set_physics_process(false)
	player.set_collision_mask_value(2,false)
	PlayerVariables.player_attacking = false
	PlayerVariables.last_skill = PlayerVariables.current_skill
	PlayerVariables.current_attack = ""
	PlayerVariables.current_skill = ""
	PlayerVariables.move = false
	player.can_flip = true
	player.camera_methods.weapon_shake_false()
	PlayerVariables.anim_finish = false
	player.combo_timer_start()

func _physics_process(delta):
	
	if Input.is_action_just_pressed("jump"):
		player.fsm.change_state(player.jump_state)
	
	if PlayerVariables.move:
		player.velocity.x = speed * player.last_direction
	else:
		zero_speed(delta)
	
	if Input.is_action_just_pressed("dash"):
		PlayerVariables.next_skill = ""
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1_weapon != "none":
		PlayerVariables.next_skill = "1"
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2_weapon != "none":
		PlayerVariables.next_skill = "2"
	
	if player.can_combo and PlayerVariables.next_skill != "":
		player.fsm.change_state(player.attack_2_state)
	
	if PlayerVariables.anim_finish:
		player.fsm.change_state(player.idle_state)

func zero_speed(delta: float):
	if player.velocity.x > 0:
		player.velocity.x = player.velocity.x - player.velocity.x * delta * 20
	elif player.velocity.x < 0:
		player.velocity.x = player.velocity.x + player.velocity.x * delta * -20
