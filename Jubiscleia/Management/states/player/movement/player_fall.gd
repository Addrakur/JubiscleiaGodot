class_name PlayerFall
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.direction = Input.get_axis("left","right")
	player.velocity.x = player.direction * speed
	
	if player.velocity.y > 0:
		animation.play("fall")
	else:
		animation.play("jump")
	
	if player.is_on_floor():
		if player.direction == 0:
			player.fsm.change_state(player.idle_state)
		else:
			player.fsm.change_state(player.move_state)
	
	if Input.is_action_just_pressed("jump") and player.jump_count < player.max_jump_count:
		player.jump_count += 1
		player.fsm.change_state(player.double_jump_state)
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)
	
