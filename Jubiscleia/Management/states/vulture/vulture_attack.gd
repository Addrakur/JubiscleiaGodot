class_name VultureAttack
extends State

@export var vulture: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float
@export var duration: float
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

var player_location: Vector2
var end_location: Vector2

var going_up: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	vulture.attack_area.damage = damage
	vulture.attack_area.knockback_force = knockback_force
	vulture.attack_area.knockup_force = knockup_force
	vulture.is_attacking = true
	animation.play("attack")
	vulture.velocity.x = 0
	attack()

func exit_state() -> void:
	set_physics_process(false)
	vulture.is_attacking = false

func _physics_process(_delta):
	
	if not vulture.alive:
		vulture.fsm.change_state(vulture.death_state)
	
	if vulture.position == end_location:
		if vulture.player_ref != null:
			vulture.fsm.change_state(vulture.hover_state)
		else:
			vulture.fsm.change_state(vulture.fly_state)

func attack():
	var attack_tween = get_tree().create_tween()
	attack_tween.tween_property(vulture,"position",player_location,duration)
	attack_tween.tween_property(vulture,"position",end_location,duration)
	
