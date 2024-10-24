class_name SpikeShieldEnemyAttack
extends State

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var attack_timer: Timer

var attack: String

var move: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	parent.is_attacking = true
	parent.velocity.x = 0
	animation.play("attack")
	parent.attack_area.attack_name = parent.name + attack

func exit_state() -> void:
	set_physics_process(false)
	parent.is_attacking = false
	attack_timer.start()

func _physics_process(_delta: float) -> void:
	pass

func _on_animation_finished(anim):
	if anim == "attack":
		parent.fsm.change_state(parent.idle_state)
