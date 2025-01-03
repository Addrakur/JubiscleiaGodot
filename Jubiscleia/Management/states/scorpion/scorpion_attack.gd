class_name ScorpionAttack
extends State

@export var scorpion: Scorpion
@export var animation: AnimationPlayer

@export var attack_distance: float
@export var speed: float

var direction: float
var new_x: float

var prepared: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	scorpion.is_attacking = true
	new_x = scorpion.player_ref.position.x - attack_distance if scorpion.player_ref.position.x < scorpion.position.x else scorpion.player_ref.position.x + attack_distance
	direction = 1 if new_x > scorpion.position.x else -1
	scorpion.velocity.x = 0
	animation.play("attack_prepare")

func exit_state() -> void:
	set_physics_process(false)
	scorpion.is_attacking = false
	scorpion.attack_timer.start()
	prepared = false

func _physics_process(_delta):
	if prepared:
		scorpion.velocity.x = direction * speed * scorpion.speed
	
	
	if scorpion.position.x > new_x and direction == 1 or scorpion.position.x < new_x and direction == -1 or scorpion.raycast.is_colliding():
		scorpion.fsm.change_state(scorpion.idle_state)
	

func attack_area_entered(body):
	if body.is_in_group(scorpion.attack_area.target):
		scorpion.fsm.change_state(scorpion.idle_state)

func _on_animation_finished(anim: StringName) -> void:
	if anim == "attack_prepare":
		animation.play("attack")
		prepared = true
