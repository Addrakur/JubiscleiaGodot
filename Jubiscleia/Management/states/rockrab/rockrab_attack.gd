extends LimboState

@export var parent: Rockrab
@export var animation: AnimationPlayer
@export var tree: BTPlayer
@export var attack_timer: Timer
@export var collision_polygon_2d: CollisionPolygon2D

func _enter():
	parent.velocity.x = 0
	tree.active = true

func _exit():
	parent.can_attack = false
	attack_timer.start()
	tree.active = false
	set_deferred(str(collision_polygon_2d.disabled), true)

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "stomp_attack":
		dispatch("attack_to_idle")
