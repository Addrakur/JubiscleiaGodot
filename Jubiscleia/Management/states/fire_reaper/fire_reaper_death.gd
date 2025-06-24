extends LimboState

@export var parent: FireReaper
@export var animation: AnimationPlayer


func _enter() -> void:
	parent.collision_damage.set_deferred("disabled", true)
	animation.play("dead")
	parent.limit.erase(parent)

func _update(_delta):
	parent.velocity.x = 0

func _on_animation_finished(anim):
	if anim == "dead":
		parent.queue_free()
