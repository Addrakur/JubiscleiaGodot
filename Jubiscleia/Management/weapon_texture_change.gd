extends TextureRect

@export var textures: Array[Texture2D]

func _ready():
	match PlayerVariables.get(name):
		"axe":
			texture = textures[0]
		"spear":
			texture = textures[1]
		"sword":
			texture = textures[2]
