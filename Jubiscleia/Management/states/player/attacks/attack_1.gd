class_name PlayerAttack1
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
	animation.play(PlayerVariables.current_skill + "_attack_1")
	player.can_combo = false

	match PlayerVariables.current_skill:
		"axe":
			damage = PlayerVariables.axe_1_damage
			knockback_force = PlayerVariables.axe_1_knockback
			knockup_force = PlayerVariables.axe_1_knockup
		"sword":
			speed = PlayerVariables.sword_1_speed
			direction = player.last_direction
			damage = PlayerVariables.sword_1_damage
			knockback_force = PlayerVariables.sword_1_knockback
			knockup_force = PlayerVariables.sword_1_knockup
		"spear":
			damage = PlayerVariables.spear_1_damage
			knockback_force = PlayerVariables.spear_1_knockback
			knockup_force = PlayerVariables.spear_1_knockup
	
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
		player.fsm.change_state(player.attack_2_state)
	
	if player.health_component.is_getting_hit:
		PlayerVariables.current_skill = ""

func _on_animation_finished(anim):
	if anim == PlayerVariables.last_skill + "_attack_1":
		player.fsm.change_state(player.idle_state)
 
