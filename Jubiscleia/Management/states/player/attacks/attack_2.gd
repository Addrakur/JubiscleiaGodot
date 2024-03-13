class_name PlayerAttack2
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
	animation.play(PlayerVariables.current_skill + "_attack_2")
	player.can_combo = false

	match PlayerVariables.current_skill:
		"axe":
			speed = PlayerVariables.axe_2_speed
			direction = player.last_direction
			damage = PlayerVariables.axe_2_damage
			knockback_force = PlayerVariables.axe_2_knockback
			knockup_force = PlayerVariables.axe_2_knockup
		"sword":
			damage = PlayerVariables.sword_2_damage
			knockback_force = PlayerVariables.sword_2_knockback
			knockup_force = PlayerVariables.sword_2_knockup
		"spear":
			damage = PlayerVariables.spear_2_damage
			knockback_force = PlayerVariables.spear_2_knockback
			knockup_force = PlayerVariables.spear_2_knockup
	
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
		player.velocity.x = speed * direction
	
	if Input.is_action_just_pressed("attack_button_1"):
		PlayerVariables.current_skill = PlayerVariables.skill_1
	
	if Input.is_action_just_pressed("attack_button_2"):
		PlayerVariables.current_skill = PlayerVariables.skill_2
	
	if player.can_combo and PlayerVariables.current_skill != "":
		player.fsm.change_state(player.attack_3_state)
	
	if player.health_component.is_getting_hit:
		PlayerVariables.current_skill = ""

func _on_animation_finished(anim):
	if anim == PlayerVariables.last_skill + "_attack_1":
		player.fsm.change_state(player.idle_state)
 
