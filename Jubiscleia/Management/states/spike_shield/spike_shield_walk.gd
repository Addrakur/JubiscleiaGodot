class_name SpikeShieldEnemyWalk
extends State

@export var parent: SpikeShieldEnemy
@export var animation: AnimationPlayer
@export var speed: float
@export var wander_limit: float
@export var attack_timer: Timer

var new_x: float

var move: bool = false

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	new_position()
	animation.play("walk",-1,0.9)
	

func exit_state() -> void:
	set_physics_process(false)
	new_x = 0
	parent.direction = 0

func _physics_process(_delta):
	if new_x != 0 and parent.direction != 0 and move:
		parent.velocity.x = parent.direction * speed
	else:
		parent.velocity.x = 0
	
	if parent.position.x > new_x and parent.direction == 1 or parent.position.x < new_x and parent.direction == -1:
		parent.fsm.change_state(parent.idle_state)
	
	if parent.can_attack_player:
		if parent.attack_timer.is_stopped():
			parent.fsm.change_state(parent.attack_state)
		else:
			parent.fsm.change_state(parent.idle_state)

func new_position():
	if parent.player_ref == null:
		new_x = randf_range(parent.limit.limit_polygon.polygon[0].x + wander_limit, parent.limit.limit_polygon.polygon[2].x - wander_limit)
	else:
		new_x = parent.player_ref.position.x
	
	if parent.position.x > new_x:
		parent.direction = -1
	else:
		parent.direction = 1
	
func move_true():
	move = true
	
func move_false():
	move = false
