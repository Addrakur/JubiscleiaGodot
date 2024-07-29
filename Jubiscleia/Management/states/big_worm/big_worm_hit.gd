class_name BigWormHit
extends State

@export var big_worm: CharacterBody2D
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
	big_worm.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	big_worm.health_component.is_getting_hit = false
	anim_finish = false
	big_worm.health_component.last_attack = ""

func _physics_process(_delta):
	if not big_worm.velocity == Vector2(0,0):
		big_worm.velocity.x = big_worm.velocity.x - big_worm.velocity.x * 0.02
	
	if direction == 1 and big_worm.velocity.x <= hit_recover_limit or direction == -1 and big_worm.velocity.x >=-hit_recover_limit:
		if big_worm.is_on_floor() and anim_finish:
			big_worm.fsm.change_state(big_worm.move_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	big_worm.velocity = Vector2(knockback_force * direction, knockup_force)
	
