class_name KitsuneAttack
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer
@export var attack_timer: Timer



func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	kitsune.is_attacking = true
	kitsune.velocity.x = 0
	if kitsune.can_attack_short_range:
		animation.play("attack_1")
	else:
		animation.play("attack_2")

func exit_state() -> void:
	set_physics_process(false)
	#kitsune.health_component.invulnerable = false
	kitsune.is_attacking = false

func _on_animation_finished(anim):
	if anim == "attack_2" or anim == "attack_1":
		kitsune.fsm.change_state(kitsune.idle_state)

func spawn_fireball():
	var proj = Paths.fireball.instantiate()
	if kitsune.can_attack_short_range:
		proj.animation_level = 2
		set_spawn_point(28 * kitsune.direction,44)
	else:
		proj.animation_level = 1
		set_spawn_point(47 * kitsune.direction,10)
	add_child(proj)
	proj.position = kitsune.attack_spawn_point.global_position
	proj.direction = kitsune.direction
	proj.texture.flip_h = true if kitsune.direction == -1 else false
	proj.collision.scale.x = proj.direction

func set_spawn_point(cord_x: float, cord_y:float):
	kitsune.attack_spawn_point.position = Vector2(cord_x,cord_y)

func attack_timer_start():
	attack_timer.start()
