class_name ElementManager
extends Node2D

@export var max_element_stack: float
@export var animation: AnimationPlayer
@export var element_timer: Timer

var elements: Array[String] = ["fire","water","air","earth"]

func _ready() -> void:
	for element in elements:
		PlayerVariables.set(str(PlayerVariables.get(element + "_stack_count")), 0)
	
	# Solução temporária
	reset_counters()

func _process(_delta: float) -> void:
	if PlayerVariables.elemental_rupture:
		return
	
	for element in elements:
		if PlayerVariables.get(element + "_stack_count") >= max_element_stack:
			PlayerVariables.elemental_rupture = true
			rupture(element)
			print(element)


func rupture(element: String) -> void:
	#for variable in elements:
		#if variable != element:
			#PlayerVariables.set(str(PlayerVariables.get(variable + "_stack_count")), 0)
		#else:
			#PlayerVariables.set(str(PlayerVariables.get(element + "_stack_count")), max_element_stack)
	animation.play(element)
	element_timer.start()
	
	# Solução temporária
	match element:
		"water":
			PlayerVariables.water_stack_count = max_element_stack
			PlayerVariables.fire_stack_count = 0
			PlayerVariables.earth_stack_count = 0
			PlayerVariables.air_stack_count = 0
		"fire":
			PlayerVariables.fire_stack_count = max_element_stack
			PlayerVariables.water_stack_count = 0
			PlayerVariables.earth_stack_count = 0
			PlayerVariables.air_stack_count = 0
		"earth":
			PlayerVariables.earth_stack_count = max_element_stack
			PlayerVariables.fire_stack_count = 0
			PlayerVariables.water_stack_count = 0
			PlayerVariables.air_stack_count = 0
		"air":
			PlayerVariables.air_stack_count = max_element_stack
			PlayerVariables.fire_stack_count = 0
			PlayerVariables.water_stack_count = 0
			PlayerVariables.earth_stack_count = 0


func _input(event: InputEvent) -> void:
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
	PlayerVariables.elemental_rupture = false
	#for element in elements:
		#PlayerVariables.set(str(PlayerVariables.get(element + "_stack_count")), 0)
	
	# Solução temporária
	reset_counters()
	
	animation.play("corruption_level_0")
	print("timer timeout")

func reset_counters():
	PlayerVariables.water_stack_count = 0
	PlayerVariables.fire_stack_count = 0
	PlayerVariables.earth_stack_count = 0
	PlayerVariables.air_stack_count = 0
