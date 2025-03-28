@tool
class_name UpgradeButton
extends TextureButton

@export var description: String
@export var upgrades_needed: Array[UpgradeButton]

var active: bool = false
var can_upgrade: bool = false

var player: bool
var life_up: float = 0
var poise_up: float = 0
var dash_down: float = 0
var damage_up: float = 0
var knockback_up: float = 0

var water: bool
var water_stacks_down: float = 0
var water_duration_up: float = 0
var water_slow_up: float = 0
var water_slow_duration_up: float = 0

var air: bool
var air_stacks_down: float = 0
var air_duration_up: float = 0
var air_area_up: float = 0
var air_area_damage_up: float = 0

var fire: bool
var fire_stacks_down: float = 0
var fire_duration_up: float = 0
var fire_damage_up: float = 0

var earth: bool
var earth_stacks_down: float = 0
var earth_duration_up: float = 0
var earth_temp_life_up: float = 0

func _ready() -> void:
	if SkillTree.get(name):
		active = true
	else:
		active = false

func _process(_delta: float) -> void:
	if active:
		for upgrade in upgrades_needed:
			if not upgrade.active:
				active = false
				return
		disabled = false
		button_pressed = true
		SkillTree.set(name,true)
		return
	else:
		SkillTree.set(name,false)
		button_pressed = false
		
		if can_upgrade_check():
			disabled = false
		else:
			disabled = true

func can_upgrade_check() -> bool:
	if upgrades_needed != []:
		for upgrade in upgrades_needed:
				if not upgrade.active:
					if active:
						active = false
						undo_effect()
					return false
		return true
	return true

func _on_pressed() -> void:
	if active:
		active = false
		SkillTree.set(name,false)
		undo_effect()
	elif not active and can_upgrade_check():
		active = true
		SkillTree.set(name,true)
		set_effect()
	

func set_effect():
	SkillTree.bonus_life += life_up
	SkillTree.bonus_poise += poise_up
	SkillTree.bonus_dash += dash_down
	SkillTree.bonus_base_damage += damage_up
	SkillTree.bonus_knockback += knockback_up
	
	SkillTree.water_stacks_buff += water_stacks_down
	SkillTree.water_duration_buff += water_duration_up
	SkillTree.water_slow_buff += water_slow_up
	SkillTree.water_slow_duration_buff += water_slow_duration_up

	SkillTree.fire_stack_buff += fire_stacks_down
	SkillTree.fire_duration_buff += fire_duration_up
	SkillTree.fire_damage_buff += fire_damage_up

	SkillTree.air_stacks_buff += air_stacks_down
	SkillTree.air_duration_buff += air_duration_up
	SkillTree.air_area_buff += air_area_up
	SkillTree.air_area_damage_buff += air_area_damage_up

	SkillTree.earth_stacks_buff += earth_stacks_down
	SkillTree.earth_duration_buff += earth_duration_up
	SkillTree.earth_temp_life_buff += earth_temp_life_up
	

func undo_effect():
	SkillTree.bonus_life -= life_up
	SkillTree.bonus_poise -= poise_up
	SkillTree.bonus_dash -= dash_down
	SkillTree.bonus_base_damage -= damage_up
	SkillTree.bonus_knockback -= knockback_up
	
	SkillTree.water_stacks_buff -= water_stacks_down
	SkillTree.water_duration_buff -= water_duration_up
	SkillTree.water_slow_buff -= water_slow_up
	SkillTree.water_slow_duration_buff -= water_slow_duration_up

	SkillTree.fire_stack_buff -= fire_stacks_down
	SkillTree.fire_duration_buff -= fire_duration_up
	SkillTree.fire_damage_buff -= fire_damage_up

	SkillTree.air_stacks_buff -= air_stacks_down
	SkillTree.air_duration_buff -= air_duration_up
	SkillTree.air_area_buff -= air_area_up
	SkillTree.air_area_damage_buff -= air_area_damage_up

	SkillTree.earth_stacks_buff -= earth_stacks_down
	SkillTree.earth_duration_buff -= earth_duration_up
	SkillTree.earth_temp_life_buff -= earth_temp_life_up
	

func _get_property_list() -> Array[Dictionary]:
	var ret: Array[Dictionary] = []
	
	ret.append({
		"name": "Player",
		"type": TYPE_BOOL,
		})
	
	if player:
		ret.append({
		"name": "Life Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Poise Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Dash Down",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Damage Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Knockback Up",
		"type": TYPE_FLOAT,
		})
	
	
	ret.append({
		"name": "Water",
		"type": TYPE_BOOL,
		})
	
	if water:
		ret.append({
		"name": "Water Stacks Down",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Water Duration Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Water Slow Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Water Slow Duration Up",
		"type": TYPE_FLOAT,
		})
	
	ret.append({
		"name": "Air",
		"type": TYPE_BOOL,
		})
	
	if air:
		ret.append({
		"name": "Air Stacks Down",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Air Duration Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Air Area Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Air Area Damage Up",
		"type": TYPE_FLOAT,
		})
	
	ret.append({
		"name": "Fire",
		"type": TYPE_BOOL,
		})
	
	if fire:
		ret.append({
		"name": "Fire Stacks Down",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Fire Duration Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Fire Damage Up",
		"type": TYPE_FLOAT,
		})
	
	ret.append({
		"name": "Earth",
		"type": TYPE_BOOL,
		})
	
	if earth:
		ret.append({
		"name": "Earth Stacks Down",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Earth Duration Up",
		"type": TYPE_FLOAT,
		})
		ret.append({
		"name": "Earth Temp Life Up",
		"type": TYPE_FLOAT,
		})
	
	
	return ret
	
func _set(prop_name: StringName, val) -> bool:
	var retval: bool = true
	match prop_name:
		"Player":
			player = val
			notify_property_list_changed()
		"Life Up":
			life_up = val
		"Poise Up":
			poise_up = val
		"Dash Down":
			dash_down = val
		"Damage Up":
			damage_up = val
		"Knockback Up":
			knockback_up = val
		
		
		"Water":
			water = val
			notify_property_list_changed()
		"Water Stacks Down":
			water_stacks_down = val
		"Water Duration Up":
			water_duration_up = val
		"Water Slow Up":
			water_slow_up = val
		"Water Slow Duration Up":
			water_slow_duration_up = val
		
		"Air":
			air = val
			notify_property_list_changed()
		"Air Stacks Down":
			air_stacks_down = val
		"Air Duration Up":
			air_duration_up = val
		"Air Area Up":
			air_area_up = val
		"Air Area Damage Up":
			air_area_damage_up = val
		
		"Fire":
			fire = val
			notify_property_list_changed()
		"Fire Stacks Down":
			fire_stacks_down = val
		"Fire Duration Up":
			fire_duration_up = val
		"Fire Damage Up":
			fire_damage_up = val
		
		"Earth":
			earth = val
			notify_property_list_changed()
		"Earth Stacks Down":
			earth_stacks_down = val
		"Earth Duration Up":
			earth_duration_up = val
		"Earth Temp Life Up":
			earth_temp_life_up = val
		
		_:
			retval = false
	return retval

func _get(prop_name: StringName):
	match prop_name:
		"Player":
			return player
		"Life Up":
			return life_up
		"Poise Up":
			return poise_up
		"Dash Down":
			return dash_down
		"Damage Up":
			return damage_up
		"Knockback Up":
			return knockback_up
		
		"Water":
			return water
		"Water Stacks Down":
			return water_stacks_down
		"Water Duration Up":
			return water_duration_up
		"Water Slow Up":
			return water_slow_up
		"Water Slow Duration Up":
			return water_slow_duration_up
		
		"Air":
			return air
		"Air Stacks Down":
			return air_stacks_down
		"Air Duration Up":
			return air_duration_up
		"Air Area Up":
			return air_area_up
		"Air Area Damage Up":
			return air_area_damage_up
		
		"Fire":
			return fire
		"Fire Stacks Down":
			return fire_stacks_down
		"Fire Duration Up":
			return fire_duration_up
		"Fire Damage Up":
			return fire_damage_up
		
		"Earth":
			return earth
		"Earth Stacks Down":
			return earth_stacks_down
		"Earth Duration Up":
			return earth_duration_up
		"Earth Temp Life Up":
			return earth_temp_life_up
		
	return null
