class_name SniperEnemyIdle
extends LimboState

@export var parent: SniperEnemy
@export var laser: Line2D
@export var raycast: RayCast2D

func _enter():
	print("enter idle")

func _update(_delta: float):
	if parent.player_ref == null:
		get_player()
	parent.arm_texture.rotation = parent.arm_texture.global_position.direction_to(parent.player_ref.global_position + Vector2(0, -16)).angle() # Rotaciona o braço para mirar no jogador
	
	if raycast.is_colliding():
		var collision_point: Vector2 = raycast.get_collision_point()
		laser.points[1] = collision_point - parent.global_position + Vector2(0,16)
		

func get_player():
	parent.player_ref = GameSettings.player
