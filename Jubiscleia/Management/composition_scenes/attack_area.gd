class_name AttackArea
extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

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
	if body.is_in_group(target) and not body.health_component.invulnerable and body.alive:
		body.health_component.update_health(damage, knockup_force, knockback_force, 1 if body.position.x > parent.position.x else -1, attack_name, poise_damage, parent.position.x, parent) # Chama a função que aplica o dano no alvo
		
		if parent.is_in_group("player"): # Verifica se quem bateu foi o jogador
			PlayerVariables.hit_amount += 1
			if not PlayerVariables.elemental_rupture:
				var current_meter_value =  PlayerVariables.get(PlayerVariables.get(PlayerVariables.current_skill + "_element") + "_stack_count") # Recebe o valor atual do contador do elemento da arma
				var new_value = current_meter_value + PlayerVariables.get(PlayerVariables.current_skill + "_element_amount") # Calcula o novo valor
				PlayerVariables.set(PlayerVariables.get(PlayerVariables.current_skill + "_element") + "_stack_count", new_value) # Vincula o novo valor ao contador
			
		if parent.is_in_group("player_object") and not PlayerVariables.elemental_rupture:
			var current_meter_value = PlayerVariables.get(parent.element + "_stack_count")
			var new_value = current_meter_value + PlayerVariables.get(parent.skill + "_element_amount")
			PlayerVariables.set(parent.element + "_stack_count", new_value)
			#print(PlayerVariables.get(parent.element + "_stack_count"))
				
			
			if PlayerVariables.my_knockup == true: # Verifica se o ataque do do jogador faz ele tomar knockup
				parent.jump_attack_state.stop_false()
				parent.jump_attack_state.get_out_of_state()
				parent.fsm.change_state(parent.jump_state)
				
				
		if one_hit_destroy:
			parent.can_destroy = true
		
		if body.is_in_group("shield_enemy") and parent.is_in_group("player_object"):
			parent.can_destroy = true
	
	elif body.is_in_group("terrain") and destroy_on_terrain:
		parent.can_destroy = true
