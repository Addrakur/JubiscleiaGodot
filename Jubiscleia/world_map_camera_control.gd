extends CharacterBody2D


@export var speed: float
var horizontal_direction: float
var vertical_direction: float

func _ready() -> void:
	horizontal_direction = 0
	vertical_direction = 0

func _physics_process(delta: float) -> void:
	horizontal_direction = Input.get_axis("map_left", "map_right")
	vertical_direction = Input.get_axis("map_up", "map_down")
	velocity = Vector2(horizontal_direction * speed * delta, vertical_direction * speed * delta)
	move_and_slide()
