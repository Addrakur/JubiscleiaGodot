extends Node2D

@export var element: String
@onready var timer: Timer = $timer
@onready var texture: Sprite2D = $texture
@export var animation: AnimationPlayer
@onready var botao_e: Sprite2D = $BotaoE

var can_collect: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		botao_e.visible = true
		can_collect = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		botao_e.visible = false
		can_collect = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("collect_orb") and can_collect:
		collect_orb()

func set_animation():
	animation.play(element)

func collect_orb():
	GameSettings.player.element_manager.rupture(element)
	queue_free()
