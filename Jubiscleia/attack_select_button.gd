extends TextureButton

@export var parent: Control
@export var attack: String
@export var skill: int

@export var change_attack_buttons: Array[TextureButton]
@export var normal_textures: Array[CompressedTexture2D]
@export var focus_textures: Array[CompressedTexture2D]
@export var disabled_textures: Array[CompressedTexture2D]

func _process(_delta: float) -> void:
	if PlayerVariables.get("skill_" + str(skill) + "_weapon") == "none" or PlayerVariables.get("skill_" + str(skill) + "_element") == "none":
		disabled = true
		return
	disabled = false

func _on_pressed() -> void:
	parent.choose_attack_to_change("skill_" + str(skill) + "_" + attack, self, skill)
	var attack_options: Array[Node] = parent.attack_options.get_children()
	for child in attack_options:
		if not child.name.contains("s" + str(skill)):
			attack_options.erase(child)
	var attack_reform: String = attack.left(-2) if attack != "finisher" else attack
	for button in attack_options:
		if not change_attack_buttons.has(button) or not PlayerVariables.get(PlayerVariables.get("skill_" + str(skill) + "_weapon") + "_" + PlayerVariables.get("skill_" + str(skill) + "_element") + "_" + attack_reform + "_" + str(button.number)):
			button.disabled = true
		else:
			button.disabled = false
			if PlayerVariables.get("skill_" + str(skill) + "_" + attack) == button.number:
				button.button_pressed = true
			else:
				button.button_pressed = false
	
func change_texture(attack_number: int):
	texture_normal = normal_textures[attack_number-1]
	texture_focused = focus_textures[attack_number-1]
	texture_hover = focus_textures[attack_number-1]
	texture_disabled = disabled_textures[attack_number-1]
