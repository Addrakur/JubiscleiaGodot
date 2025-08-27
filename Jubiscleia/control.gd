extends CanvasLayer

@export var level: Level

var time: float = 0.0
var minutes: float = 0
var seconds: float = 0

@onready var min: Label = $timer/min
@onready var sec: Label = $timer/sec


func _process(delta: float) -> void:
	if level.player.alive:
		time += delta
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
		min.text = "%02d:" % minutes
		sec.text = "%02d" % seconds
