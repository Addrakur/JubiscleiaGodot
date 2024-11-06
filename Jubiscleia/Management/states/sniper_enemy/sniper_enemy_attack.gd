class_name SniperEnemyAttack
extends LimboState

@export var parent: SniperEnemy
@export var proj_speed: float
@export var proj_spawn: Marker2D
@export var target_position: Marker2D
@export var proj_tween_duration: float
@export var animation: AnimationPlayer
@export var attack_timer: Timer

func _enter():
	animation.play("attack_prep")

func _exit():
	attack_timer.start()

func _update(_delta: float) -> void:
	pass

func spawn_projectile():
	var proj: Node2D = Paths.sniper_enemy_projectile.instantiate()
	parent.add_child(proj)
	proj.global_position = proj_spawn.global_position
	proj.target_position = target_position.global_position
	proj.tween_duration = proj_tween_duration


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_prep":
		spawn_projectile()
		dispatch("attack_to_idle")
