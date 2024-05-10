extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

@export var damage: float
@export var knockup_force: float
@export var knockback_force: float

@export_group("Bools")
@export var one_hit_destroy: bool = false
@export var destroy_on_terrain: bool = false

func _ready():
	#print(parent.name + ": " + name + ": " + str(damage))
	pass

func on_body_entered(body):
	if body.is_in_group(target) and not body.health_component.invulnerable and body.alive:
		body.health_component.update_health(damage) # Chama a função que aplica o dano no alvo
		if parent.is_in_group("player"): # Verifica se quem bateu foi o jogador
			PlayerVariables.hit_amount += 1
			if not parent.is_in_group("projectile"):
				parent.corruption_manager.hit_timer.start()
				
			if PlayerVariables.my_knockup == true: # Verifica se o ataque do do jogador faz ele tomar knockup
				parent.velocity.y = PlayerVariables.spear_jump_my_knockup
				
		if not body.health_component.knockback_imunity: # Verifica se o alvo atingido é imune a knockback, se nao for ele aplica os efeitos
			body.hit_state.knockup_force = knockup_force * body.hit_state.knock_multi
			body.hit_state.knockback_force = knockback_force * body.hit_state.knock_multi
			body.hit_state.direction = 1 if body.position.x > parent.position.x else -1
			
		if body.fsm.state == body.hit_state: # Gambiarra que faz o alvo reiniciar o hit state
			body.fsm.change_state(body.state)
			body.fsm.change_state(body.hit_state)
			
		
		if body.is_in_group("player"):
			body.corruption_manager.time_penalty()
	
	
	elif body.is_in_group("terrain") and destroy_on_terrain:
		parent.queue_free()
	
	if one_hit_destroy:
		parent.queue_free()
	
