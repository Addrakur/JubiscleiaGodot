class_name SpearSkeletonHit
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float
@export var hit_recover_limit: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.stop()
	animation.play("hit")
	skeleton.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	skeleton.health_component.is_getting_hit = false
	anim_finish = false

func _physics_process(_delta):
	
	if not skeleton.velocity == Vector2(0,0):
		skeleton.velocity.x = skeleton.velocity.x - skeleton.velocity.x * 0.02
	
	if direction == 1 and skeleton.velocity.x <= hit_recover_limit or direction == -1 and skeleton.velocity.x >=-hit_recover_limit:
		if skeleton.is_on_floor() and anim_finish:
			skeleton.fsm.change_state(skeleton.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	skeleton.velocity = Vector2(knockback_force * direction, knockup_force)
	
