class_name SnakeAttack
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

@export var damage: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	snake.attack_area.damage = damage
	animation.play("attack")
	snake.velocity.x = 0
	snake.attack_timer.start()

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if snake.health_component.is_getting_hit:
		snake.fsm.change_state(snake.hit_state)
	
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)

func _on_animation_finished(anim):
	if anim == "attack":
		if snake.player_ref == null or !GameSettings.player_alive:
			snake.fsm.change_state(snake.move_state)
		else:
			snake.fsm.change_state(snake.idle_state)
