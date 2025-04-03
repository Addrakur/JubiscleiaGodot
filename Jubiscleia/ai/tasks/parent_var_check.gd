extends BTAction

@export var var_name: String

func _tick(_delta:float) -> Status:
	if agent.parent.get(var_name):
		return SUCCESS
	else:
		return FAILURE
