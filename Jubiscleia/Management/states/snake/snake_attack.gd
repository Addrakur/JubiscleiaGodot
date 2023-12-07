class_name SnakeAttack
extends State

@export var snake: CharacterBody2D
@export var animation: AnimationPlayer

@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	snake.attack_area.damage = damage
	snake.attack_area.knockback_force = knockback_force
	snake.attack_area.knockup_force = knockup_force
	snake.is_attacking = true
	snake.velocity.x = 0
	animation.play("attack")

func exit_state() -> void:
	set_physics_process(false)
	snake.is_attacking = false

func _physics_process(_delta):
	if snake.health_component.is_getting_hit:
		snake.fsm.change_state(snake.hit_state)
	
	if not snake.alive:
		snake.fsm.change_state(snake.death_state)

func _on_animation_finished(anim):
	if anim == "attack":
		snake.attack_timer.start()
		if snake.can_attack_player:
			snake.fsm.change_state(snake.idle_state)
		else:
			snake.fsm.change_state(snake.chase_state)

func can_attack_area_exited(body):
	if body == snake.player_ref:
		snake.can_attack_player = false
