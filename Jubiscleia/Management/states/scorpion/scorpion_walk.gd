class_name ScorpionWalk
extends State

@export var scorpion: CharacterBody2D
@export var animation: AnimationPlayer
@export var off_set_wander: float
@export var speed: float

var direction: float

var new_x: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	new_position()
	animation.play("walk")
	

func exit_state() -> void:
	set_physics_process(false)
	new_x = 0
	direction = 0

func _physics_process(_delta):
	if new_x != 0 and direction != 0:
		scorpion.velocity.x = direction * speed
	
	if scorpion.position.x > new_x and direction == 1 or scorpion.position.x < new_x and direction == -1:
		scorpion.fsm.change_state(scorpion.idle_state)
	
	if scorpion.player_ref != null and scorpion.player_on_limit and scorpion.attack_timer.is_stopped():
		scorpion.fsm.change_state(scorpion.attack_state)
	
	if scorpion.health_component.is_getting_hit:
		scorpion.fsm.change_state(scorpion.hit_state)
	
	if not scorpion.alive:
		scorpion.fsm.change_state(scorpion.death_state)

func new_position():
	var chance: float
	chance = randf_range(0,10)
	if chance > 5:
		new_x = scorpion.starting_x.position.x + randf_range(20, off_set_wander)
	elif chance < 5:
		new_x = scorpion.starting_x.position.x - randf_range(20, off_set_wander)
	else:
		new_x = scorpion.starting_x.position.x
	
	if scorpion.position.x > new_x:
		direction = -1
	else:
		direction = 1
