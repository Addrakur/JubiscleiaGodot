extends BTAction

@export var func_name: String

func _tick(_delta: float) -> Status:
	var callable = Callable(self, func_name)
	callable.call()
	return SUCCESS
