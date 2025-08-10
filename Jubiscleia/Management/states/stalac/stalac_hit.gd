extends LimboState

@export var parent: Stalac
@export var animation: AnimationPlayer
@export var knock_multi: float
@export var hit_recover_limit: float
@export var collision_damage: CollisionShape2D

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool

func _enter() -> void:
	collision_damage.set_deferred("disabled", true)
	parent.health_component.is_getting_hit = true
	parent.velocity.x = 0
	if parent.rotation != 0:
		parent.position.y += 40
	parent.rotation = 0
	parent.texture.rotation = 0
	animation.play("hit")
	knockback()

func _exit() -> void:
	parent.health_component.is_getting_hit = false
	anim_finish = false
	parent.health_component.last_attack = ""
	collision_damage.set_deferred("disabled", false)

func _update(delta):
	parent.velocity.x = parent.velocity.x - parent.velocity.x * delta * 2.5
	
	if direction == 1 and parent.velocity.x <= hit_recover_limit or direction == -1 and parent.velocity.x >=-hit_recover_limit:
		if parent.is_on_floor() and anim_finish:
			dispatch("hit_to_idle")

func knockback():
	parent.velocity = Vector2(knockback_force * direction, knockup_force)

func _on_animation_animation_finished(anim: StringName) -> void:
	if anim == "hit":
		anim_finish = true
