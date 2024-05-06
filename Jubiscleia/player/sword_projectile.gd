extends Node2D

@export var speed: float
var direction: float
@onready var animation: AnimationPlayer = $Animations
@onready var texture: Sprite2D = $Texture
@onready var attack_area: CollisionPolygon2D = $AttackArea/CollisionPolygon2D
@onready var attack_comp: Area2D = $AttackArea

func _ready():
	animation.play(str(PlayerVariables.corruption_level))
	attack_comp.damage = PlayerVariables.get("sword_" + str(PlayerVariables.corruption_level) + "_3_Projectile_damage")

func _process(delta):
	position.x += direction * speed * delta
	if direction == -1:
		texture.flip_h = true
		attack_area.scale.x = -1
