extends CharacterBody2D

@export var speed: float
var player_on_chase_range: bool
var player_on_attack_range: bool

func _ready() -> void:
	pass
	

func _physics_process(_delta):
	if player_on_chase_range:
		if player_on_attack_range:
			attack()
		else:
			chase_player()
	else:
		idle()
	

func idle() -> void:
	pass
	

func chase_player() -> void:
	pass
	

func attack() -> void:
	pass
	
