class_name SwordSkeletonProtect
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var protect_duration: Timer

var timeout: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	protect_duration.start()
	skeleton.health_component.defending = true
	animation.play("protect")
	skeleton.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)
	timeout = false
	skeleton.protect_cooldown.start()
	skeleton.health_component.defending = false
	skeleton.attack_state.attack_timer.stop()

func _physics_process(_delta: float) -> void:
	if timeout or skeleton.player_ref == null:
		skeleton.fsm.change_state(skeleton.idle_state)

func _on_protect_duration_timeout() -> void:
	timeout = true
