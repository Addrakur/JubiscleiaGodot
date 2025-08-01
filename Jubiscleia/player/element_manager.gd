class_name ElementManager
extends Node2D

@export var max_element_stack: float
@export var timer: float
@export var player: Player
@export var animation: AnimationPlayer
@export var element_timer: Timer

var active: bool = true

var elements: Array[String] = ["fire","water","air","earth"]

func _ready() -> void:
	reset_elemental_counters()

func _process(_delta: float) -> void:
	if player.fsm.state == player.heal_state:
		return
	
	if PlayerVariables.elemental_rupture != "":
		if element_timer.time_left <= 3:
			animation.play(PlayerVariables.elemental_rupture + "_ending")
		
		if PlayerVariables.elemental_rupture == "earth" and player.health_component.current_temp_life <= 0:
			end_rupture()
		return
	
	for element in elements:
		if PlayerVariables.get(element + "_stack_count") >= max_element_stack:
			rupture(element)

func rupture(element: String) -> void:
	for variable in elements:
		if variable != element:
			PlayerVariables.set(variable + "_stack_count", 0)
		else:
			PlayerVariables.set(element + "_stack_count", max_element_stack)
	PlayerVariables.elemental_rupture = element
	animation.play(element)
	element_timer.wait_time = timer
	element_timer.start()
	
	# Solução temporária
	match element:
		"fire":
			PlayerVariables.damage_mult = 1.5
		"earth":
			player.health_component.current_temp_life = player.health_component.max_temp_life

func _on_element_timer_timeout() -> void:
	end_rupture()

func reset_elemental_counters():
	for element in elements:
		PlayerVariables.set(element + "_stack_count", 0)
	
	PlayerVariables.elemental_rupture = ""

func end_rupture():
	PlayerVariables.elemental_rupture = ""
	
	reset_elemental_counters()
	PlayerVariables.damage_mult = 1
	player.health_component.current_temp_life = 0
	
	animation.play("no_rupture")
