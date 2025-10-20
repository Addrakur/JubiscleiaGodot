extends LimboState

@export var parent: LightningDash
@export var animation: AnimationPlayer
@export var collision_damage: CollisionShape2D

func _enter() -> void:
	collision_damage.set_deferred("disabled", true)
	animation.play("dead")
	parent.limit.erase(parent)

func _update(_delta):
	parent.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "dead":
		parent.queue_free()
