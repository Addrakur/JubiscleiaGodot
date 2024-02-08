class_name ScorpionAttack
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer

@export var attack_distance: float
@export var speed: float
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

var direction: float
var new_x: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	scorpion.attack_area.damage = damage
	scorpion.attack_area.knockback_force = knockback_force
	scorpion.attack_area.knockup_force = knockup_force
	scorpion.is_attacking = true
	new_x = scorpion.player_ref.position.x - attack_distance if scorpion.player_ref.position.x < scorpion.position.x else scorpion.player_ref.position.x + attack_distance
	direction = 1 if new_x > scorpion.position.x else -1
	animation.play("attack")

func exit_state() -> void:
	set_physics_process(false)
	scorpion.is_attacking = false
	scorpion.attack_timer.start()

func _physics_process(_delta):
	scorpion.velocity.x = direction * speed
	
	if scorpion.health_component.is_getting_hit:
		scorpion.fsm.change_state(scorpion.hit_state)
	
	if scorpion.position.x > new_x and direction == 1 or scorpion.position.x < new_x and direction == -1 or scorpion.raycast.is_colliding():
		scorpion.fsm.change_state(scorpion.idle_state)
	
	if scorpion.player_ref == null:
		scorpion.fsm.change_state(scorpion.idle_state)
	
	if not scorpion.alive:
		scorpion.fsm.change_state(scorpion.death_state)
