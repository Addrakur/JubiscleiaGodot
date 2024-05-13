class_name KitsuneAttack
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var fireball = preload("res://enemies/kitsune_fire.tscn")

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	kitsune.health_component.invulnerable = true
	attack_timer.start()
	kitsune.is_attacking = true
	kitsune.velocity.x = 0
	if kitsune.can_attack_melee:
		animation.play("attack_1")
	else:
		animation.play("attack_2")

func exit_state() -> void:
	set_physics_process(false)
	kitsune.health_component.invulnerable = false
	kitsune.is_attacking = false

func _on_animation_finished(anim):
	if anim == "attack_1" or anim == "attack_2":
		kitsune.fsm.change_state(kitsune.idle_state)

func spawn_fireball():
	var proj = fireball.instantiate()
	if kitsune.can_attack_short_range:
		proj.animation_level = 2
	else:
		proj.animation_level = 1
	add_child(proj)
	proj.position = kitsune.attack_spawn_point.global_position
	proj.direction = kitsune.direction
	proj.texture.flip_h = true if kitsune.direction == -1 else false
