extends LimboState

@export var parent: Rockrab
@export var animation: AnimationPlayer
@export var idle_min_time: float
@export var idle_max_time: float

@onready var idle_timer: Timer = $"../../idle_timer"

func _enter():
	parent.velocity.x = 0
	idle_timer.wait_time = randf_range(idle_min_time, idle_max_time)
	idle_timer.start()
	animation.play("idle")

func _exit():
	pass

func _update(delta) -> void:
	pass

func _on_idle_timer_timeout() -> void:
	dispatch("idle_to_walk")
