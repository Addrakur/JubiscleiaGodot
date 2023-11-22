class_name PlayerHit
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	if player.is_on_floor():
		player.jump_count = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == "hit" or player.is_on_floor():
		player.health_component.is_getting_hit = false
		player.health_component.invulnerable = false
		player.fsm.change_state(player.idle_state)
