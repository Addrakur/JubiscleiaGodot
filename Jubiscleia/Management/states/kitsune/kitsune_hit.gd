class_name KitsuneHit
extends State

@export var kitsune: CharacterBody2D
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
	kitsune.health_component.is_getting_hit = true
	animation.play("hit")
	kitsune.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	kitsune.health_component.is_getting_hit = false
	anim_finish = false
	kitsune.health_component.last_attack = ""

func _physics_process(_delta):
	
	if not kitsune.velocity == Vector2(0,0):
		kitsune.velocity.x = kitsune.velocity.x - kitsune.velocity.x * 0.02
	
	if direction == 1 and kitsune.velocity.x <= hit_recover_limit or direction == -1 and kitsune.velocity.x >=-hit_recover_limit:
		if kitsune.is_on_floor() and anim_finish:
			kitsune.fsm.change_state(kitsune.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	kitsune.velocity = Vector2(knockback_force * direction, knockup_force)
	
