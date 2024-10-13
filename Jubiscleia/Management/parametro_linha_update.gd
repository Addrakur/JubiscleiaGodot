extends HBoxContainer

@export var default_value: float
@export var slider_min: float
@export var slider_max: float
@export var slider_step: float

var number_label: Label
var slider: HSlider
var default_button: Button

var children: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	children = get_children()
	for item in children:
		if item.name == "number":
			number_label = item
		elif item.name == "slider":
			slider = item
		elif item.name == "button":
			default_button = item
	
	slider.rounded = false
	slider.min_value = slider_min
	slider.max_value = slider_max
	slider.step = slider_step
	slider.value = Parameters.get(name)
	number_label.text = str(Parameters.get(name))
	
	default_button.pressed.connect(button_pressed.bind())
	slider.value_changed.connect(number_label_update.bind())
	slider.drag_ended.connect(update_value.bind())
	
	if Parameters.get(name) != default_value:
			number_label.add_theme_color_override("font_color", Color.RED)

func button_pressed():
	if Parameters.get(name) != null:
		slider.value = default_value
		Parameters.set(name,default_value)
		number_label.remove_theme_color_override("font_color")
	else:
		print(name)

func number_label_update(value: float):
	number_label.text = str(value)

func update_value(ended: bool):
	if ended:
		Parameters.set(name,slider.value)
		if Parameters.get(name) != default_value:
			number_label.add_theme_color_override("font_color", Color.RED)
	
	
