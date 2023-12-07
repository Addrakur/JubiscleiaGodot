class_name VultureDeath
extends State

@export var vulture: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("dead")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	vulture.queue_free()

