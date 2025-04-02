class_name BossTree
extends CharacterBody2D

@onready var hsm: LimboHSM = $hsm
@onready var idle_state: LimboState = $hsm/idle

func _ready() -> void:
	init_state_machine()

func init_state_machine():
	hsm.initial_state = idle_state
	hsm.initialize(self)
	hsm.set_active(true)
