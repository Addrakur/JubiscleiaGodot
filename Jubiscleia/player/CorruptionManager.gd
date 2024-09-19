extends Node2D

@export var player: CharacterBody2D
@export var hit_timer: Timer
@export var animation: AnimationPlayer
@export var base_level: float
@export var max_level: float

@export_group("Hit Numbers")
@export var hit_0_to_1: float
@export var hit_1_to_2: float
@export var hit_2_to_3: float

@export_group("Seconds Limit")
@export var sec_0: float
@export var sec_1: float
@export var sec_2: float
@export var sec_3: float

var target_hit_count: float

func _ready():
	set_parameters()
	PlayerVariables.hit_amount = 0
	PlayerVariables.corruption_level = base_level
	set_target_hit_count()
	set_hit_timer()

func _process(_delta):
	level_manager()
	animation_manager()
	
	#print(int(hit_timer.time_left))
	

func hit_timer_timeout():
	PlayerVariables.hit_amount = 0
	if PlayerVariables.corruption_level != base_level:
		corruption_downgrade()

func level_manager():
	if PlayerVariables.corruption_level < max_level:
		if PlayerVariables.hit_amount >= target_hit_count:
			corruption_upgrade()

func corruption_upgrade():
	PlayerVariables.corruption_level += 1
	set_hit_timer()
	if PlayerVariables.corruption_level < max_level:
		set_target_hit_count()
	

func corruption_downgrade():
	PlayerVariables.corruption_level -= 1
	set_hit_timer()
	if PlayerVariables.corruption_level > base_level:
		set_target_hit_count()
		hit_timer.start()
	

func set_target_hit_count():
	target_hit_count = PlayerVariables.hit_amount + get("hit_" + str(PlayerVariables.corruption_level) + "_to_" + str(PlayerVariables.corruption_level + 1))

func set_hit_timer():
	hit_timer.wait_time = get("sec_" + str(PlayerVariables.corruption_level))

func animation_manager():
	if hit_timer.time_left <= 3 and PlayerVariables.corruption_level != base_level:
		animation.play("losing_level_" + str(PlayerVariables.corruption_level))
	elif target_hit_count - PlayerVariables.hit_amount <= 3  and PlayerVariables.corruption_level != max_level:
		animation.play("level_up_" + str(PlayerVariables.corruption_level))
	else:
		animation.play("corruption_level_" + str(PlayerVariables.corruption_level))

func time_penalty():
	if hit_timer.time_left > 3:
		hit_timer.wait_time = hit_timer.time_left - 3
	else:
		hit_timer.wait_time = 0.01
	hit_timer.start()
	set_hit_timer()

func set_parameters():
	hit_0_to_1 = Parameters.player_hits_0_1
	hit_1_to_2 = Parameters.player_hits_1_2
	hit_2_to_3 = Parameters.player_hits_2_3

	sec_0 = Parameters.player_0_timer
	sec_1 = Parameters.player_1_timer
	sec_2 = Parameters.player_2_timer
	sec_3 = Parameters.player_3_timer
