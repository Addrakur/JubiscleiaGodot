class_name BigWormDeath
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	print("enter")
	big_worm.health_component.is_getting_hit = false
	animation.play("death")
	big_worm.limit.erase(big_worm)

func exit_state() -> void:
	set_physics_process(false)
	print("exit")

func _physics_process(_delta):
	big_worm.velocity.x = 0

