class_name PlayerHeal
extends State

@export var player: Player
@export var animation: AnimationPlayer
@export var element_manager: ElementManager
@export var healing_amount: float

var anim_finish: bool = false

var element_time_left: float

var heal_level: float

func enter_state():
	player.velocity.x = 0
	anim_finish = false
	animation.play(PlayerVariables.elemental_rupture + "_healing")
	element_time_left = element_manager.element_timer.time_left
	element_manager.element_timer.stop()

func _physics_process(_delta: float) -> void:
	if element_time_left > 7:
		heal_level = 3
	elif element_time_left > 3:
		heal_level = 2
	else:
		heal_level = 1

func exit_state():
	if anim_finish:
		element_manager.end_rupture()
	else:
		animation.play(PlayerVariables.elemental_rupture)
		element_manager.element_timer.wait_time = element_time_left
		element_manager.element_timer.start()

func _on_aura_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == PlayerVariables.elemental_rupture + "_healing":
		heal()
		anim_finish = true
		player.fsm.change_state(player.idle_state)

func heal():
	if player.health_component.current_health + healing_amount >= player.health_component.max_health:
		player.health_component.current_health = player.health_component.max_health
	else:
		player.health_component.current_health += healing_amount * heal_level
