class_name SnakeHit
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	snake.velocity = Vector2(0,0)
	animation.play("hit")
	knockback()
	snake.attack_timer.start()

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)
	
	if snake.velocity > Vector2(0,0):
		snake.velocity = Vector2(snake.velocity.x - snake.velocity.x * 0.05,snake.velocity.y - snake.velocity.y * 0.05)
	
	if snake.velocity <= Vector2(50,50) and anim_finish:
		if snake.is_on_floor():
			snake.health_component.is_getting_hit = false
			if snake.player_ref != null:
				snake.fsm.change_state(snake.move_state)
			else: 
				snake.fsm.change_state(snake.chase_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true
		

func knockback():
	snake.velocity = Vector2(knockback_force * direction, knockup_force)
