class_name BigWormIdle
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("idle")
	big_worm.velocity.x = 0
	
func exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(_delta):
	if big_worm.player_ref == null:
		big_worm.fsm.change_state(big_worm.move_state)
	
	if big_worm.player_ref != null and big_worm.attack_timer.is_stopped():
		big_worm.fsm.change_state(big_worm.attack_state)

func can_attack_area_exited(body):
	if body == big_worm.player_ref:
		big_worm.player_ref = null
