extends TextureButton

@export var parent: Control
@export var number: int
@export var skill: int

func _on_pressed() -> void:
	parent.set_attack(number, skill)

func _process(_delta: float) -> void:
	if parent.attack_being_changed_1 == "" and parent.attack_being_changed_2 == "":
		disabled = true
