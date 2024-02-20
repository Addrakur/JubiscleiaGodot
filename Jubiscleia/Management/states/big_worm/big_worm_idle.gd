class_name BigWormIdle
extends State

@export var big_worm: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play(big_worm.normal_or_fire + "_idle")
	big_worm.velocity.x = 0
	
func exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(_delta):
	if big_worm.player_ref == null:
		big_worm.fsm.change_state(big_worm.move_state)
	elif big_worm.player_ref.position.x > big_worm.position.x:
		big_worm.right()
	else:
		big_worm.left()
	
	if big_worm.player_ref != null and big_worm.attack_timer.is_stopped():
		big_worm.fsm.change_state(big_worm.attack_state)
	
	if big_worm.health_component.is_getting_hit:
		big_worm.fsm.change_state(big_worm.hit_state)
	
	if not big_worm.alive:
		big_worm.fsm.change_state(big_worm.death_state)
	

func can_attack_area_exited(body):
	if body == big_worm.player_ref:
		big_worm.player_ref = null
