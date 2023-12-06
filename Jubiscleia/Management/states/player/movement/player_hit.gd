class_name PlayerHit
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

var knockup_force: float
var knockback_force: float
var direction: float

var hit_timer: float = 0.1

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("hit")
	#hit_timer = 0.1
	if player.is_on_floor():
		player.jump_count = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	if not player.alive:
		player.fsm.change_state(player.death_state)
	
	hit_timer -= delta
	if hit_timer > 0:
		knockback()

func _on_animation_finished(anim):
	if anim == "hit" or player.is_on_floor():
		player.health_component.is_getting_hit = false
		player.health_component.invulnerable = false
		player.fsm.change_state(player.idle_state)

func knockback():
	player.velocity = Vector2(knockback_force * direction, knockup_force)
