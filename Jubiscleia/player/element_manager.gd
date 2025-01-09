class_name ElementManager
extends Node2D

@export var max_element_stack: float
@export var animation: AnimationPlayer
@export var element_timer: Timer

var elements: Array[String] = ["fire","water","air","earth"]

func _ready() -> void:
	reset_elemental_counters()

func _process(_delta: float) -> void:
	if PlayerVariables.elemental_rupture != "":
		if element_timer.time_left <= 3:
			animation.play(PlayerVariables.elemental_rupture + "_ending")
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
	element_timer.start()
	
	# Solução temporária
	match element:
		"fire":
			PlayerVariables.damage_mult = 1.5

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_1):
		print("Water: ",PlayerVariables.water_stack_count)
		print("Fire: ",PlayerVariables.fire_stack_count)
		print("Earth: ",PlayerVariables.earth_stack_count)
		print("Air: ",PlayerVariables.air_stack_count)
	
	if Input.is_key_pressed(KEY_2):
		PlayerVariables.water_stack_count = 0
		PlayerVariables.fire_stack_count = 0
		PlayerVariables.earth_stack_count = 0
		PlayerVariables.air_stack_count = 0


func _on_element_timer_timeout() -> void:
	PlayerVariables.elemental_rupture = ""
	
	reset_elemental_counters()
	PlayerVariables.attack_speed = 1
	PlayerVariables.damage_mult = 1
	
	animation.play("no_rupture")

func reset_elemental_counters():
	for element in elements:
		PlayerVariables.set(element + "_stack_count", 0)
	
	PlayerVariables.elemental_rupture = ""
