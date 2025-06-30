extends LimboState

@export var parent: FireReaper
@export var animation: AnimationPlayer
@export var attack_timer: Timer
@onready var collision_polygon_2d: CollisionPolygon2D = $"../../AttackArea/CollisionPolygon2D"

func _enter():
	animation.play("attack",-1,parent.speed,false)
	parent.velocity.x = 0

func _exit():
	parent.can_attack = false
	attack_timer.start()
	set_deferred(str(collision_polygon_2d.disabled), true)

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		dispatch("attack_to_idle")
