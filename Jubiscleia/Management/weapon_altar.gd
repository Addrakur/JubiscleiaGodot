extends Area2D

@export_enum("axe","spear","sword","gauntlet") var weapon: String
@export_enum("fire","water","air","earth") var element: String
@onready var animation: AnimationPlayer = $animation

var interacted: bool = false

func _ready() -> void:
	animation.play(weapon + "_" + element)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		PlayerVariables.set(weapon + "_" + element + "_unlocked", true)
		animation.play(weapon + "_" + element + "_interacted")
		interacted = true
