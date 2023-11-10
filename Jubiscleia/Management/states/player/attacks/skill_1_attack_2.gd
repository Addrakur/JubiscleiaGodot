class_name PlayerSkill1Attack2
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.attack_area.damage = damage
	animation.play(PlayerVariables.skill_1 + "_attack_2")
	player.can_combo = false
	player.combo_1 = false
	player.combo_2 = false

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = 0
	player.direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("attack_button_1"):
		player.combo_1 = true
		player.combo_2 = false
	
	if Input.is_action_just_pressed("attack_button_2"):
		player.combo_2 = true
		player.combo_1 = false
	
	if player.can_combo:
		if player.combo_1:
			player.fsm.change_state(player.skill_1_attack_3_state)
		elif player.combo_2:
			player.fsm.change_state(player.skill_2_attack_3_state)
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == PlayerVariables.skill_1 + "_attack_2":
		player.fsm.change_state(player.idle_state)
