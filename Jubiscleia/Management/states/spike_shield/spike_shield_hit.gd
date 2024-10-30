class_name SpikeShieldEnemyHit
extends LimboState

@export var parent: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float
@export var hit_recover_limit: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool = false

func _enter() -> void:
	parent.health_component.is_getting_hit = true
	#animation.stop()
	animation.play("hit")
	parent.velocity.x = 0
	knockback()

func _exit() -> void:
	parent.health_component.is_getting_hit = false
	anim_finish = false
	parent.health_component.last_attack = ""

func _update(_delta):
	
	if not parent.velocity == Vector2(0,0):
		parent.velocity.x = parent.velocity.x - parent.velocity.x * 0.02
	
	if direction == 1 and parent.velocity.x <= hit_recover_limit or direction == -1 and parent.velocity.x >=-hit_recover_limit:
		if parent.is_on_floor() and anim_finish:
			dispatch("hit_to_idle")

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	parent.velocity = Vector2(knockback_force * direction, knockup_force)
	
