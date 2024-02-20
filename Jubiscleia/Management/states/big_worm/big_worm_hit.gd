class_name BigWormHit
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer

var knockup_force: float
var knockback_force: float
var direction: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play(big_worm.normal_or_fire + "_hit")
	big_worm.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if not big_worm.alive:
		big_worm.fsm.change_state(big_worm.death_state)

func _on_animation_finished(anim):
	if anim == big_worm.normal_or_fire + "_hit":
		big_worm.health_component.is_getting_hit = false
		big_worm.fsm.change_state(big_worm.idle_state)
