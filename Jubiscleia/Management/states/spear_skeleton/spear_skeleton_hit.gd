class_name SpearSkeletonHit
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	skeleton.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	skeleton.health_component.is_getting_hit = false

func _physics_process(_delta):
	
	if skeleton.velocity > Vector2(0,0):
		skeleton.velocity = Vector2(skeleton.velocity.x - skeleton.velocity.x * 0.05,skeleton.velocity.y - skeleton.velocity.y * 0.05)
	
	if skeleton.velocity <= Vector2(50,50) and anim_finish:
		if skeleton.is_on_floor():
			skeleton.fsm.change_state(skeleton.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	skeleton.velocity = Vector2(knockback_force * direction, knockup_force)
	
