class_name PlayerAttack3
extends State

@export var player: Player
@export var animation: AnimationPlayer
@export var attack_area: CollisionPolygon2D

var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	PlayerVariables.current_skill = PlayerVariables.next_skill
	PlayerVariables.next_skill = ""
	player.next_attack = 1
	player.attack_number.text = "1"
	player.can_combo = false
	
	player.combo_timer.stop()
	animation.play(PlayerVariables.current_skill + "_3",-1,PlayerVariables.attack_speed,false)
	PlayerVariables.current_attack = PlayerVariables.current_skill + "_3"
	player.attack_area.attack_name = PlayerVariables.current_attack

	speed = PlayerVariables.get(str(PlayerVariables.current_skill) + "_3_speed")
	
	player.attack_area.damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_3_damage") * PlayerVariables.damage_mult
	player.attack_area.knockback_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_3_knockback")
	player.attack_area.knockup_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_3_knockup")
	player.attack_area.poise_damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_3_poise")

func exit_state() -> void:
	set_physics_process(false)
	PlayerVariables.player_attacking = false
	PlayerVariables.last_skill = PlayerVariables.current_skill
	PlayerVariables.current_attack = ""
	PlayerVariables.current_skill = ""
	PlayerVariables.move = false
	player.can_flip = true
	player.camera_methods.weapon_shake_false()
	PlayerVariables.anim_finish = false
	player.combo_timer_start()

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("jump"):
		player.fsm.change_state(player.jump_state)
	
	if PlayerVariables.move:
		player.velocity.x = speed * player.last_direction
	else:
		zero_speed()
	
	if Input.is_action_just_pressed("dash"):
		PlayerVariables.next_skill = ""
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_1
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_2
	
	if player.can_combo and PlayerVariables.next_skill != "":
		player.fsm.change_state(player.attack_1_state)
	
	if PlayerVariables.anim_finish:
		player.fsm.change_state(player.idle_state)

func zero_speed():
	if player.velocity.x > 0:
		player.velocity.x = player.velocity.x - player.velocity.x * 0.1
	elif player.velocity.x < 0:
		player.velocity.x = player.velocity.x + player.velocity.x * -0.1
