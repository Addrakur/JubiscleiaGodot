class_name PlayerHit
extends State

@export var player: CharacterBody2D
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
	player.can_flip = false
	player.health_component.is_getting_hit = true
	player.health_component.invulnerable = true
	player.can_dash = false
	animation.play("hit")
	player.velocity.x = 0
	knockback()

func exit_state() -> void:
	set_physics_process(false)
	player.health_component.is_getting_hit = false
	anim_finish = false
	player.can_dash = true
	player.can_flip = true
	player.inv_timer.start()
	player.health_component.last_attack = ""

func _physics_process(_delta):
	
	if not player.velocity == Vector2(0,0):
		player.velocity.x = player.velocity.x - player.velocity.x * 0.02
	
	if direction == 1 and player.velocity.x <= hit_recover_limit or direction == -1 and player.velocity.x >=-hit_recover_limit:
		if player.is_on_floor() and anim_finish:
			player.fsm.change_state(player.idle_state)

func _on_animation_finished(anim):
	if anim == "hit":
		anim_finish = true

func knockback():
	player.velocity = Vector2(knockback_force * direction, knockup_force)
	
