extends StaticBody2D

@export var left_side: bool
@onready var sprite_2d = $Sprite2D

func _ready():
	if left_side:
		sprite_2d.flip_h = true
