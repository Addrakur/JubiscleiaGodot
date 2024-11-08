extends Control

@export var parent: PlayerInterface
@export var element: String
@onready var progress_bar: TextureProgressBar = $progress_bar
@onready var animation: AnimationPlayer = $animation

func _ready() -> void:
	animation.play(element)
	progress_bar.max_value = parent.element_manager.max_element_stack

func _process(_delta: float) -> void:
	progress_bar.value = PlayerVariables.get(element + "_stack_count")
