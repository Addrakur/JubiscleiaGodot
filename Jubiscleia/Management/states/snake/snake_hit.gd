class_name SnakeHit
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer
@export var knock_multi: float
@export var hit_recover_limit: float

var knockup_force: float
var knockback_force: float
var direction: float

var anim_finish: bool

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.stop()
	animation.play("hit")
	snake.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	snake.health_component.is_getting_hit = false
	anim_finish = false

func _physics_process(_delta):
	
	if not snake.velocity == Vector2(0,0):
		snake.velocity.x = snake.velocity.x - snake.velocity.x * 0.02
	
	if direction == 1 and snake.velocity.x <= hit_recover_limit or direction == -1 and snake.velocity.x >=-hit_recover_limit:
		if snake.is_on_floor() and anim_finish:
			snake.fsm.change_state(snake.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	snake.velocity = Vector2(knockback_force * direction, knockup_force)
	
