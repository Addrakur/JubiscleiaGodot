class_name PlayerSwordAttack2
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("sword_attack_2")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = 0
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == "sword_attack_2":
		player.fsm.change_state(player.idle_state)
