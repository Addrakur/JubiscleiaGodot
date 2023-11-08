class_name PlayerAxeAttack1
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var damage: float
@export var knockback_force: float
@export var knockup_force: float

var can_combo: bool
var combo: bool

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.attack_area.damage = damage
	animation.play("axe_attack_1")
	can_combo = false
	combo = false

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.velocity.x = 0
	player.direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("attack_button_1"):
		combo = true
	
	if combo and can_combo:
		player.fsm.change_state(player.axe_attack_2_state)
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)

func _on_animation_finished(anim):
	if anim == "axe_attack_1":
		player.fsm.change_state(player.idle_state)
	

func move() -> void:
	if player.direction != 0:
		player.fsm.change_state(player.move_state)

func can_combo_true() -> void:
	can_combo = true
