class_name SnakeHit
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

var anim_finish: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	snake.attack_timer.start()

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)
	
	if anim_finish and snake.is_on_floor():
		snake.health_component.is_getting_hit = false
		if snake.player_ref != null:
			snake.fsm.change_state(snake.move_state)
		else: 
			snake.fsm.change_state(snake.chase_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true
