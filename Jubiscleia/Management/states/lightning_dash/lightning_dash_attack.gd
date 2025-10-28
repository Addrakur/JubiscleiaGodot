extends LimboState

@export var parent: LightningDash
@export var animation: AnimationPlayer
@export var dash_speed: float

@onready var attack_area_collision: CollisionShape2D = $"../../enemy_attack_area/attack_area_collision"

var can_move: bool = false
var attacking: bool = false

func _enter():
	print("enter attack")
	parent.velocity.x = 0
	animation.play("attack")
	set_direction()

func _update(delta) -> void:
	if can_move:
		parent.velocity.x = dash_speed * parent.direction * delta
	
	if parent.is_on_wall_raycast.is_colliding() and attacking:
		dispatch("attack_to_stun")

func _exit():
	print("exit attack")
	can_move = false
	attacking = false

func can_move_toggle(t_or_f: bool):
	can_move = t_or_f

func set_direction():
	var player_pos_x: float = parent.player_ref.position.x
	if player_pos_x > parent.position.x:
		parent.direction = 1
		parent.right()
	else:
		parent.direction = -1
		parent.left()

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		dispatch("attack_to_stun")

func attacking_true():
	attacking = true
