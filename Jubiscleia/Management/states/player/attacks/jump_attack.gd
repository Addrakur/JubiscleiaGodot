class_name PlayerJumpAttack
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var move_speed: float
var damage: float
var knockback_force: float
var knockup_force: float

var speed: float
var direction: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	PlayerVariables.last_skill = PlayerVariables.current_skill
	animation.play(PlayerVariables.current_skill + "_jump_attack")
	player.can_combo = false

	match PlayerVariables.current_skill:
		"axe":
			damage = PlayerVariables.axe_jump_damage
			knockback_force = PlayerVariables.axe_jump_knockback
			knockup_force = PlayerVariables.axe_jump_knockup
			player.velocity.x = 0
		"sword":
			damage = PlayerVariables.sword_jump_damage
			knockback_force = PlayerVariables.sword_jump_knockback
			knockup_force = PlayerVariables.sword_jump_knockup
		"spear":
			damage = PlayerVariables.spear_jump_damage
			knockback_force = PlayerVariables.spear_jump_knockback
			knockup_force = PlayerVariables.spear_jump_knockup
			PlayerVariables.my_knockup = true
	
	player.attack_area.damage = damage
	player.attack_area.knockback_force = knockback_force
	player.attack_area.knockup_force = knockup_force
	PlayerVariables.current_skill = ""

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0
	PlayerVariables.my_knockup = false
	PlayerVariables.last_skill = ""

func _physics_process(_delta):
	
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	match PlayerVariables.last_skill:
		"axe":
			player.override_gravity = player.fall_gravity * 2
		"spear":
			player.velocity.x = player.direction * move_speed
		"sword":
			player.velocity.x = player.direction * move_speed
	
	if player.is_on_floor() and PlayerVariables.last_skill == "axe":
		player.override_gravity = 0
		animation.play("axe_jump_attack_finish")

func _on_animation_finished(anim):
	if PlayerVariables.last_skill == "sword" or PlayerVariables.last_skill == "spear":
		if anim == PlayerVariables.last_skill + "_jump_attack":
			player.fsm.change_state(player.fall_state)
