class_name SnakeHit
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

var knockup_force: float
var knockback_force: float
var direction: float
var anim_finish: bool = false
var hit_timer: float = 0.1

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	hit_timer = 0.1
	snake.attack_timer.start()

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)
	
	hit_timer -= delta
	if hit_timer > 0:
		knockback()

func _on_animation_finished(anim):
	if anim == "hit" and snake.is_on_floor():
		snake.health_component.is_getting_hit = false
		if snake.player_ref != null:
			snake.fsm.change_state(snake.move_state)
		else: 
			snake.fsm.change_state(snake.chase_state)

func knockback():
	snake.velocity = Vector2(knockback_force * direction, knockup_force)
