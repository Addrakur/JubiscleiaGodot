class_name PlayerSwordAttack1
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
var can_cancel: bool

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("sword_attack_1")
	can_cancel = false

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = 0
	player.direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("basic_Attack") and can_cancel:
		player.fsm.change_state(player.sword_attack_2_state)
	
	if player.direction != 0 and can_cancel:
		player.fsm.change_state(player.move_state)
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == "sword_attack_1":
		player.fsm.change_state(player.idle_state)

func can_cancel_true():
	can_cancel = true
