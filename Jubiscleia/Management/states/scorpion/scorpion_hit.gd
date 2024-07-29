class_name ScorpionHit
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float
@export var hit_recover_limit: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.stop()
	animation.play("hit")
	scorpion.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	scorpion.health_component.is_getting_hit = false
	anim_finish = false

func _physics_process(_delta):
	
	if not scorpion.velocity == Vector2(0,0):
		scorpion.velocity.x = scorpion.velocity.x - scorpion.velocity.x * 0.02
	
	if direction == 1 and scorpion.velocity.x <= hit_recover_limit or direction == -1 and scorpion.velocity.x >=-hit_recover_limit:
		if scorpion.is_on_floor() and anim_finish:
			scorpion.fsm.change_state(scorpion.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true
		scorpion.health_component.last_attack = ""

func knockback():
	scorpion.velocity = Vector2(knockback_force * direction, knockup_force)
