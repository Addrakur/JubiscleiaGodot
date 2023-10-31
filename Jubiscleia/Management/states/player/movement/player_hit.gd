class_name PlayerHit
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	player.velocity.x = 0
	if player.is_on_floor():
		player.jump_count = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	pass

func _on_animation_finished(anim):
	if anim == "hit":
		player.health_component.is_getting_hit = false
		player.fsm.change_state(player.idle_state)
