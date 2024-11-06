class_name SniperEnemyIdle
extends LimboState

@export var parent: SniperEnemy
@export var laser: Line2D
@export var raycast: RayCast2D
@export var attack_timer: Timer
@export var animation: AnimationPlayer

func _enter():
	animation.play("idle")

func _update(_delta: float):
	if parent.player_ref == null:
		get_player()
	if parent.player_on_limit:
		if attack_timer.is_stopped():
			dispatch("idle_to_attack")
	
	
		

func get_player():
	parent.player_ref = GameSettings.player

func _input(_event: InputEvent) -> void:
	if Input.is_physical_key_pressed(KEY_1):
		dispatch("idle_to_attack")
