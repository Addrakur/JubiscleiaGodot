class_name DummyHitState
extends State

@export var dummy: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	print("enter state")
	set_physics_process(true)
	animation.play("hit")
	dummy.velocity.x = 0
	knockback()

func exit_state() -> void:
	print("exit state")
	set_physics_process(false)
	dummy.health_component.is_getting_hit = false

func _physics_process(_delta):
	
	if not dummy.velocity == Vector2(0,0):
		dummy.velocity = Vector2(dummy.velocity.x - dummy.velocity.x * 0.02,dummy.velocity.y - dummy.velocity.y * 0.02)
	
	if direction == 1 and dummy.velocity <= Vector2(10 ,10) or direction == -1 and dummy.velocity >= Vector2(-10 ,10):
		if dummy.is_on_floor() and anim_finish:
			dummy.fsm.change_state(dummy.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	dummy.velocity = Vector2(knockback_force * direction, knockup_force)
	
