extends LimboState

@export var parent: Rockrab
@export var animation: AnimationPlayer
@export var idle_min_time: float
@export var idle_max_time: float
@export var tree: BTPlayer

@export var idle_timer: Timer

func _enter():
	parent.velocity.x = 0
	idle_timer.wait_time = randf_range(idle_min_time, idle_max_time)
	idle_timer.start()
	animation.play("idle")
	tree.active = true

func _exit():
	parent.can_move = false
	tree.active = false

func _update(_delta) -> void:
	if parent.player_ref != null:
		if parent.player_ref.position.x > parent.position.x:
			parent.right()
		else:
			parent.left()

func _on_idle_timer_timeout() -> void:
	parent.can_move = true
