class_name PlayerAttack3
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
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
	if PlayerVariables.corruption_level == 3:
		animation.play(PlayerVariables.current_skill + "_attack_3_corrupted")
	else:
		animation.play(PlayerVariables.current_skill + "_attack_3")
	player.can_combo = false

	match PlayerVariables.current_skill:
		"axe":
			damage = PlayerVariables.axe_3_damage
			knockback_force = PlayerVariables.axe_3_knockback
			knockup_force = PlayerVariables.axe_3_knockup
		"sword":
			damage = PlayerVariables.sword_3_damage
			knockback_force = PlayerVariables.sword_3_knockback
			knockup_force = PlayerVariables.sword_3_knockup
		"spear":
			speed = PlayerVariables.spear_3_speed
			direction = player.last_direction
			damage = PlayerVariables.spear_3_damage
			knockback_force = PlayerVariables.spear_3_knockback
			knockup_force = PlayerVariables.spear_3_knockup
	
	player.attack_area.damage = damage
	player.attack_area.knockback_force = knockback_force
	player.attack_area.knockup_force = knockup_force
	
	PlayerVariables.current_skill = ""

func exit_state() -> void:
	set_physics_process(false)
	PlayerVariables.last_skill = ""
	PlayerVariables.move = false

func _physics_process(_delta):
	player.velocity.x = 0
	player.direction = Input.get_axis("left","right")
	
	if PlayerVariables.move:
		player.velocity.x = speed * player.last_direction

func _on_animation_finished(anim):
	if anim == PlayerVariables.last_skill + "_attack_3" or anim == PlayerVariables.last_skill + "_attack_3_corrupted":
		player.fsm.change_state(player.idle_state)
 
