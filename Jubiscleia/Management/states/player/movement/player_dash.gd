class_name PlayerDash
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
var speed: float

var direction: float

var enemy: Array[CharacterBody2D]

var anim_finish: bool = false
var passed_enemy: bool = false

func _ready():
	set_physics_process(false)
	speed = Parameters.player_dash_speed

func enter_state() -> void:
	player.set_collision_mask_value(2,false)
	player.set_collision_layer_value(1,false)
	player.collision.shape.size = Vector2(15,10)
	player.floor_snap_length = 0
	player.can_dash = false
	#if player.is_on_floor():
		#player.can_flip = false
	set_physics_process(true)
	if player.direction != 0:
		direction = player.direction
	else:
		direction = player.last_direction
	player.dash_cooldown.start()
	animation.play("dash")
	player.override_gravity = 0.1
	player.velocity.y = 0

func exit_state() -> void:
	set_physics_process(false)
	PlayerVariables.move = false
	player.health_component.invulnerable = false
	player.set_collision_mask_value(2,true)
	player.set_collision_layer_value(1,true)
	player.collision.shape.size = Vector2(15,28)
	player.override_gravity = 0
	player.floor_snap_length = 5
	player.can_flip = true
	anim_finish = false
	passed_enemy = false
	enemy.clear()

func _physics_process(_delta):
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	if Input.is_action_just_pressed("jump"):
		player.fsm.change_state(player.jump_state)
	
	if anim_finish and not passed_enemy or passed_enemy and enemy.is_empty():
		if player.is_on_floor():
			player.fsm.change_state(player.idle_state)
		else:
			player.fsm.change_state(player.fall_state)
	

func _on_animation_finished(anim):
	if anim == "dash":
		anim_finish = true

func _on_dash_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		passed_enemy = true
		enemy.append(body)
	
	if body.is_in_group("terrain"):
		if player.is_on_floor():
			player.fsm.change_state(player.idle_state)
		else:
			player.fsm.change_state(player.fall_state)
	

func _on_dash_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if enemy.has(body):
			enemy.erase(body)
