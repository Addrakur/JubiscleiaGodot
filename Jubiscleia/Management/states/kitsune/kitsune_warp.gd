class_name KitsuneWarp
extends State

@export var kitsune: CharacterBody2D
@export var animation: AnimationPlayer

var warp_point: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	kitsune.health_component.invulnerable = true
	animation.play("warp_out")
	warp_point = (kitsune.limit.limit_polygon.polygon[1].x + kitsune.limit.limit_polygon.polygon[2].x)/2

func exit_state() -> void:
	set_physics_process(false)
	kitsune.health_component.invulnerable = false

func _physics_process(_delta):
	pass

func _on_animation_finished(anim):
	if anim == "warp_out":
		kitsune.position.x = warp_point
		animation.play("warp_in")
	
	if anim == "warp_in":
			kitsune.fsm.change_state(kitsune.idle_state)
