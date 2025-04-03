extends BTAction

@export var dispatch_name: String

func _tick(_delta: float) -> Status:
	agent.dispatch(dispatch_name)
	return SUCCESS
