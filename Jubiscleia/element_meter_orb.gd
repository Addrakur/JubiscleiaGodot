extends TextureProgressBar

@export var element_manager: ElementManager
@export_enum("1","2") var skill: String
@export var texture: Array[CompressedTexture2D]
var element: String

func _ready() -> void:
	if PlayerVariables.get("skill_" + skill) != "none":
		set_element_meter()
	

func _process(_delta: float) -> void:
	if PlayerVariables.get("skill_" + skill) == "none":
		return
	set_element_meter()
	
	value = PlayerVariables.get(element + "_stack_count")

func set_element_meter():
	element = PlayerVariables.get("skill_" + skill + "_element")
	match element:
		"air":
			texture_progress = texture[0]
		"earth":
			texture_progress = texture[1]
		"fire":
			texture_progress = texture[2]
		"water":
			texture_progress = texture[3]
	
	max_value = element_manager.max_element_stack
