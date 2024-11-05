class_name SniperEnemyAttack
extends LimboState

@export var parent: SniperEnemy
@export var proj_speed: float
@export var proj_spawn: Marker2D
@export var target_position: Marker2D
@export var proj_tween_duration: float

func _enter():
	#print("enter attack")
	spawn_projectile()

func _exit():
	pass

func _update(_delta: float) -> void:
	pass

func spawn_projectile():
	var proj: Node2D = Paths.sniper_enemy_projectile.instantiate()
	parent.add_child(proj)
	proj.global_position = proj_spawn.global_position
	proj.target_position = target_position.global_position
	proj.tween_duration = proj_tween_duration
	
	dispatch("attack_to_idle")
