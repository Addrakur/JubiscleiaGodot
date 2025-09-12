class_name PlayerAttackArea
extends AttackArea

var current_element: String

func _physics_process(_delta):
	if body_ref != null:
		hit_func(body_ref)

func _on_body_entered(ref: Node2D) -> void:
	if not multi_hit:
		hit_func(ref)
	else:
		body_ref = ref
	
func _on_body_exited(body: Node2D) -> void:
	if body == body_ref:
		body_ref = null

func hit_func(body: Node2D):
	var body_is_target: bool = false
	if body.is_in_group("enemy") or body.is_in_group("obstacle"):
		body_is_target = true
	
	if not body_is_target:
		print("body not target")
		return
	print("body is target")
	
	if body.is_in_group("obstacle"):
		if has_elemental_weakness(current_element, body.element):
			body.health_component.update_health(damage, 0, 0,0, attack_name, 0, parent.position.x, parent)
		print("body is obstacle")
		return
	print("body is not obstacle")
	
	if not body.health_component.invulnerable and body.alive:
		if has_elemental_weakness(current_element, body.element):
			body.health_component.update_health(damage * PlayerVariables.element_extra_damage, knockup_force, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent)
		elif has_elemental_strength(current_element, body.element):
			body.health_component.update_health(damage * PlayerVariables.element_reduced_damage_damage, knockup_force, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent)
		else:
			body.health_component.update_health(damage, knockup_force, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent)
			
		if PlayerVariables.elemental_rupture == "" and GameSettings.player.element_manager.active:
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
					var nodes = body.get_children()
					var can_create: bool = true
					for node in nodes:
						if node is FireDot:
							can_create = false
					if can_create:
						var fire_dot = Paths.fire_dot.instantiate()
						fire_dot.damage = PlayerVariables.get(PlayerVariables.current_attack + "_damage") if parent.is_in_group("player") else PlayerVariables.get(parent.animation.current_animation + "_damage")
						if has_elemental_weakness("fire",body.element):
							fire_dot.damage *= PlayerVariables.element_extra_damage
						elif has_elemental_strength("fire", body.element):
							fire_dot.damage *= PlayerVariables.element_reduced_damage
						body.add_child(fire_dot)
				"air":
					var area = Paths.air_damage_area.instantiate()
					body.call_deferred("add_child",area)
					area.position = body.center_damage_area.position
					if has_elemental_weakness(current_element, body.element):
						damage *= PlayerVariables.element_extra_damage
					elif has_elemental_strength(current_element, body.element):
						damage *= PlayerVariables.element_reduced_damage
				
	
	if can_destroy_on_hit_check(body):
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
