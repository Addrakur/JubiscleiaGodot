extends BTAction

@export var var_name: String
@export var value: String

func _tick(_delta: float) -> Status:
	agent.parent.set(var_name,value)
	return SUCCESS
