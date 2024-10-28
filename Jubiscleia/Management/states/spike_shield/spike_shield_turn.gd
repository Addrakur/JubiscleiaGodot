class_name SpikeShieldEnemyTurn
extends State

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var attack: String

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("turn")
	parent.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)
	if parent.direction == 1:
		parent.left()
		parent.position.x -= 49
	else:
		parent.right()
		parent.position.x += 49

func _physics_process(_delta: float) -> void:
	pass

func _on_animation_finished(anim):
	if anim == "turn" or anim == "turn_attack":
		parent.fsm.change_state(parent.walk_state)
