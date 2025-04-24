extends Area2D

@export_enum("axe","spear") var weapon: String
@onready var animation: AnimationPlayer = $animation

var interacted: bool = false

func _ready() -> void:
	animation.play(weapon)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		PlayerVariables.set(weapon + "_unlocked", true)
		print(PlayerVariables.get(weapon + "_unlocked"))
		animation.play(weapon + "_interacted")
		interacted = true
