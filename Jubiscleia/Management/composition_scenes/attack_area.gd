class_name AttackArea
extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String
@export var targets: Array[String]

@export var damage: float
@export var knockup_force: float
@export var knockback_force: float
@export var poise_damage: float
@export var attack_name: String

@export_group("Bools")
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false
@export var single_hit_per_enemy: bool = true

var body_ref: Node2D

func _ready():
	#print(parent.name + ": " + name + ": " + str(damage))
	pass

func _physics_process(_delta):
	if body_ref != null:
		hit_func(body_ref)
		#print(parent.name + " hit " + body_ref.name)

func on_body_entered(ref):
	if single_hit_per_enemy:
		hit_func(ref)
		#print(parent.name + " hit " + ref.name)
	else:
		body_ref = ref

func on_body_exited(body):
	if body == body_ref:
		body_ref = null

func hit_func(body: Node2D):
	var body_is_target: bool = false
	for unit in targets:
		if body.is_in_group(unit):
			body_is_target = true
	
	if body_is_target and not body.health_component.invulnerable and body.alive:
		if parent.is_in_group("player") or parent.is_in_group("player_object"):
			var current_element: String = PlayerVariables.get(PlayerVariables.current_skill + "_element") if parent.is_in_group("player") else parent.element
			if body.is_in_group("obstacle"):
				if has_elemental_weakness(current_element, body.element):
					print(current_element) 
					print(damage)
					body.health_component.update_health(damage, 0, 0,0, attack_name, 0, parent.position.x, parent) # Chama a função que aplica o dano no alvo
			else:
				if PlayerVariables.elemental_rupture == "":
					var current_meter_value = PlayerVariables.get(current_element + "_stack_count") # Recebe o valor atual do contador do elemento da arma
					var new_value: float
					if has_elemental_weakness(current_element, body.element):
						new_value = current_meter_value + (PlayerVariables.get(PlayerVariables.current_skill + "_element_amount") * PlayerVariables.element_extra_stack) if parent.is_in_group("player") else current_meter_value + (PlayerVariables.get(parent.skill + "_element_amount") * PlayerVariables.element_extra_stack)# Calcula o novo valor
					elif has_elemental_strength(current_element, body.element):
						new_value = current_meter_value + (PlayerVariables.get(PlayerVariables.current_skill + "_element_amount") * PlayerVariables.element_reduced_stack) if parent.is_in_group("player") else current_meter_value + (PlayerVariables.get(parent.skill + "_element_amount") * PlayerVariables.element_reduced_stack)# Calcula o novo valor
					else:
						new_value = current_meter_value + PlayerVariables.get(PlayerVariables.current_skill + "_element_amount") if parent.is_in_group("player") else current_meter_value + PlayerVariables.get(parent.skill + "_element_amount")# Calcula o novo valor
					
					PlayerVariables.set(current_element + "_stack_count" , new_value)  # Vincula o novo valor ao contador
				else:
					match PlayerVariables.elemental_rupture:
						"water":
							var slow_timer = Paths.slow_timer.instantiate()
							body.add_child(slow_timer)
						"fire":
							var fire_dot = Paths.fire_dot.instantiate()
							var nodes = body.get_children()
							var can_create: bool = true
							for node in nodes:
								if node is FireDot:
									can_create = false
							if can_create:
								body.add_child(fire_dot)
						"air":
							var area = Paths.air_damage_area.instantiate()
							body.call_deferred("add_child",area)
							area.position = body.center_damage_area.position
				if has_elemental_weakness(current_element, body.element):
					damage *= PlayerVariables.element_extra_damage
				elif has_elemental_strength(current_element, body.element):
					damage *= PlayerVariables.element_reduced_damage
				body.health_component.update_health(damage, knockup_force, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent)
				
		else:
			body.health_component.update_health(damage, knockup_force, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent) # Chama a função que aplica o dano no alvo
	
	if one_hit_destroy or body.is_in_group("shield_enemy") and parent.is_in_group("player_object") or body.is_in_group("terrain") and destroy_on_terrain:
		parent.can_destroy = true
	

func has_elemental_weakness(parent_element: String, body_element: String) -> bool:
	if parent_element == "water" and body_element == "fire" or parent_element == "fire" and body_element == "earth" or parent_element == "earth" and body_element == "air" or parent_element == "air" and body_element == "water":
		return true
	else:
		return false

func has_elemental_strength(parent_element: String, body_element: String) -> bool:
	if parent_element == "fire" and body_element == "water" or parent_element == "earth" and body_element == "fire" or parent_element == "air" and body_element == "earth" or parent_element == "water" and body_element == "air":
		return true
	else:
		return false
