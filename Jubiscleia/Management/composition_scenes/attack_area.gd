extends Area2D

@onready var parent: Node2D = get_parent()

@export var target: String

@export var damage: float
@export var knockup_force: float
@export var knockback_force: float

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
		print(parent.name + " hit " + body_ref.name)
		if single_hit_per_enemy:
			body_ref = null

func on_body_entered(ref):
	body_ref = ref

func on_body_exited(body):
	body_ref = null

func hit_func(body: Node2D):
	if body.is_in_group(target) and not body.health_component.invulnerable and body.alive:
		body.health_component.update_health(damage, single_hit_per_enemy) # Chama a função que aplica o dano no alvo
		
		body.hit_state.knockup_force = knockup_force * body.hit_state.knock_multi # Aplica a força do knockback
		body.hit_state.knockback_force = knockback_force * body.hit_state.knock_multi # Aplica a força do knockup
		body.hit_state.direction = 1 if body.position.x > parent.position.x else -1 # Indica a direção que vai ser o knockback
		
		if parent.is_in_group("player"): # Verifica se quem bateu foi o jogador
			PlayerVariables.hit_amount += 1
			if not parent.is_in_group("projectile"):
				parent.corruption_manager.hit_timer.start()
				
			if PlayerVariables.my_knockup == true: # Verifica se o ataque do do jogador faz ele tomar knockup
				parent.jump_attack_state.stop_false()
				#parent.velocity.y = PlayerVariables.spear_jump_my_knockup
				parent.jump_attack_state.get_out_of_state()
				parent.fsm.change_state(parent.jump_state)
				
			
		if body.fsm.state == body.hit_state: # Gambiarra que faz o alvo reiniciar o hit state
			#body.fsm.change_state(body.state)
			body.fsm.change_state(body.hit_state)
			
		
		if body.is_in_group("player"):
			body.corruption_manager.time_penalty()
		
		if one_hit_destroy:
			parent.can_destroy = true
	
	
	elif body.is_in_group("terrain") and destroy_on_terrain:
		parent.can_destroy = true
