class_name SwordSkeletonAttack
extends State

@export var skeleton: SwordSkeleton
@export var animation: AnimationPlayer
@export var attack_timer: Timer
@export var speed: float

var attack: String

var move: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	skeleton.is_attacking = true
	skeleton.velocity.x = 0
	animation.play(attack, -1, skeleton.speed)
	skeleton.attack_area.attack_name = skeleton.name + attack

func exit_state() -> void:
	set_physics_process(false)
	skeleton.is_attacking = false
	attack_timer.start()

func _physics_process(_delta: float) -> void:
	if move:
		skeleton.velocity.x = skeleton.direction * speed
	else:
		skeleton.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "attack_1" or anim == "run_attack":
		animation.play("attack_2", -1, skeleton.speed)
		skeleton.attack_area.attack_name = skeleton.name + "attack_2"
	elif anim == "attack_2":
		animation.play("attack_3", -1, skeleton.speed)
		skeleton.attack_area.attack_name = skeleton.name + "attack_3"
	elif anim == "attack_3":
		skeleton.fsm.change_state(skeleton.idle_state)

func move_true():
	move = true

func move_false():
	move = false
