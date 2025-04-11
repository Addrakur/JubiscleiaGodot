extends StaticBody2D

@export_enum("fire","water","earth","air") var element: String
@export var polygon2d: Polygon2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var hit_modulate: AnimationPlayer = $hit_modulate

var obs_units: Array[ElementObstacle]
var alive: bool = true

func _ready() -> void:
	collision_polygon.polygon = polygon2d.polygon
	
	var children = get_children()
	
	for child in children:
		if child is ElementObstacle:
			obs_units.append(child)

func _physics_process(_delta: float) -> void:
	if not alive:
		destroy()

func destroy():
	queue_free()


func _on_hit_modulate_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		health_component.last_attack = ""
