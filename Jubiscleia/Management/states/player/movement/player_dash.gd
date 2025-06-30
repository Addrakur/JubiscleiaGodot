class_name PlayerDash
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var ground_raycast: RayCast2D
@export var speed: float

var direction: float

var enemy: Array[CharacterBody2D]

var anim_finish: bool = false
var passed_enemy: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	if player.is_on_floor():
		player.dash_cooldown.start()
	#player.set_collision_mask_value(2,false)
	player.set_collision_layer_value(1,false)
	player.collision.shape.size = Vector2(15,10)
	player.floor_snap_length = 0
	player.can_dash = false
	set_physics_process(true)
	if player.direction != 0:
		direction = player.direction
	else:
		direction = player.last_direction
	animation.play("dash")
	player.override_gravity = 0.1
	player.velocity.y = 0
	

func exit_state() -> void:
	set_physics_process(false)
	PlayerVariables.move = false
	player.health_component.invulnerable = false
	#player.set_collision_mask_value(2,true)
	player.set_collision_layer_value(1,true)
	player.collision.shape.size = Vector2(11,28)
	player.override_gravity = 0
	player.floor_snap_length = 5
	player.can_flip = true
	anim_finish = false
	passed_enemy = false
	enemy.clear()
	player.health_component.invulnerable = false
	

func _physics_process(_delta):
	if PlayerVariables.move:
		player.velocity.x = speed * direction
	
	if Input.is_action_just_pressed("jump") and not passed_enemy:
		player.fsm.change_state(player.jump_state)
	
	if not passed_enemy or passed_enemy and enemy.is_empty():
		if anim_finish:
			player.fsm.change_state(player.fall_state)
		
		if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1 != "none":
			PlayerVariables.next_skill = PlayerVariables.skill_1
			if ground_raycast.is_colliding():
				player.fsm.change_state(player.get("attack_" + str(player.next_attack) + "_state"))
			else:
				player.fsm.change_state(player.get("jump_attack_state"))
		if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2 != "none":
			PlayerVariables.next_skill = PlayerVariables.skill_2
			if ground_raycast.is_colliding():
				player.fsm.change_state(player.get("attack_" + str(player.next_attack) + "_state"))
			else:
				player.fsm.change_state(player.get("jump_attack_state"))
	

func _on_animation_finished(anim):
	if anim == "dash":
		anim_finish = true

func _on_dash_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		passed_enemy = true
		enemy.append(body)
		print(body.name + " entered")
	
	if body.is_in_group("terrain"):
		player.fsm.change_state(player.fall_state)
	

func _on_dash_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if enemy.has(body):
			enemy.erase(body)
		print(body.name + " exited")
