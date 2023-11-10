class_name PlayerSkill2Attack2
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
	animation.play(PlayerVariables.skill_2 + "_attack_2")
	player.can_combo = false
	player.combo = false

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = 0
	player.direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("attack_button_2"):
		player.combo = true
	
	if player.combo and player.can_combo:
		player.fsm.change_state(player.skill_2_attack_3_state)
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == PlayerVariables.skill_2 + "_attack_2":
		player.fsm.change_state(player.idle_state)
