class_name SpikeShieldEnemyIdle
extends State

@export var parent: SpikeShieldEnemy
@export var idle_timer: Timer
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	idle_timer.start()
	set_physics_process(true)
	animation.play("idle")
	parent.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if parent.can_attack_player:
		if parent.attack_timer.is_stopped():
			parent.fsm.change_state(parent.attack_state)
	elif idle_timer.is_stopped():
		parent.fsm.change_state(parent.walk_state)

func set_direction():
	if parent.player_ref.position.x > parent.position.x - 10:
		parent.direction = 1
	elif parent.player_ref.position.x < parent.position.x + 10:
		parent.direction = -1
