class_name ScorpionHit
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float

var knockup_force: float
var knockback_force: float
var direction: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	scorpion.velocity.x = 0
	knockback()
	scorpion.attack_timer.start()

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if not scorpion.alive:
		scorpion.fsm.change_state(scorpion.death_state)
	
	if scorpion.velocity > Vector2(0,0):
		scorpion.velocity = Vector2(scorpion.velocity.x - scorpion.velocity.x * 0.05,scorpion.velocity.y - scorpion.velocity.y * 0.05)

func _on_animation_finished(anim):
	if anim == "hit":
		if scorpion.is_on_floor():
			scorpion.health_component.is_getting_hit = false
			scorpion.fsm.change_state(scorpion.idle_state)

func knockback():
	scorpion.velocity = Vector2(knockback_force * direction, knockup_force)
	
