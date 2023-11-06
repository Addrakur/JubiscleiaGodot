class_name BeeAttack
extends State

@export var bee: Node2D
@export var attack_area: Area2D
@export var damage: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	attack_area.damage = damage

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	pass

