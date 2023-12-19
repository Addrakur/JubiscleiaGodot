class_name PlayerSkill1Attack3
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

var speed: float
var direction: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.attack_area.damage = damage
	player.attack_area.knockback_force = knockback_force
	player.attack_area.knockup_force = knockup_force
	animation.play(PlayerVariables.skill_1 + "_attack_3")
	
	match PlayerVariables.skill_1:
		"axe":
			damage = 6
			knockback_force = 300
			knockup_force = -150
		"sword":
			damage = 4
			knockback_force = 0
			knockup_force = -500
		"spear":
			speed = PlayerVariables.spear_3_speed
			direction = player.direction
			damage = 5
			knockback_force = 0
			knockup_force = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = 0
	player.direction = Input.get_axis("left","right")
	
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == PlayerVariables.skill_1 + "_attack_3":
		player.fsm.change_state(player.idle_state)
	
