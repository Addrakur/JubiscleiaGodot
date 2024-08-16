class_name PlayerAttack2
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var attack_area: CollisionPolygon2D

var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	#player.can_dash = false
	PlayerVariables.anim_finish = false
	player.next_attack = 3
	
	#PlayerVariables.player_attacking = true
	PlayerVariables.last_skill = PlayerVariables.current_skill
	animation.play(PlayerVariables.current_skill + "_" + str(PlayerVariables.corruption_level) + "_2")
	PlayerVariables.current_attack = PlayerVariables.current_skill + "_" + str(PlayerVariables.corruption_level) + "_2"
	player.attack_area.attack_name = PlayerVariables.current_attack
	player.can_combo = false

	speed = PlayerVariables.get(str(PlayerVariables.current_skill) + "_2_speed")
	player.attack_area.damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_" + str(PlayerVariables.corruption_level) + "_2_damage")
	player.attack_area.knockback_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_" + str(PlayerVariables.corruption_level) + "_2_knockback")
	player.attack_area.knockup_force = PlayerVariables.get(str(PlayerVariables.current_skill) + "_" + str(PlayerVariables.corruption_level) + "_2_knockup")
	player.attack_area.poise_damage = PlayerVariables.get(str(PlayerVariables.current_skill) + "_" + str(PlayerVariables.corruption_level) + "_2_poise")
	
	PlayerVariables.current_skill = ""

func exit_state() -> void:
	set_physics_process(false)
	PlayerVariables.player_attacking = false
	PlayerVariables.last_skill = ""
	PlayerVariables.move = false
	PlayerVariables.current_attack = ""
	#attack_area.disabled = true
	player.can_dash = true
	
	PlayerVariables.anim_finish = false
	
	player.combo_timer.start()

func _physics_process(_delta):
	player.velocity.x = 0
	
	if Input.is_action_just_pressed("jump"):
		player.fsm.change_state(player.jump_state)
	
	if PlayerVariables.move:
		player.velocity.x = speed * player.last_direction
	
	if Input.is_action_just_pressed("dash"):
		PlayerVariables.current_skill = ""
	
	if Input.is_action_just_pressed("attack_button_1"):
		PlayerVariables.current_skill = PlayerVariables.skill_1
	
	if Input.is_action_just_pressed("attack_button_2"):
		PlayerVariables.current_skill = PlayerVariables.skill_2
	
	if player.can_combo and PlayerVariables.current_skill != "":
		player.fsm.change_state(player.attack_3_state)
	
	if player.health_component.is_getting_hit: # Talvez precise tirar essa linha
		PlayerVariables.current_skill = ""
	
	if PlayerVariables.anim_finish:
		player.fsm.change_state(player.idle_state)
