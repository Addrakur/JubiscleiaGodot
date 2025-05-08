extends BTAction

func _tick(_delta:float) -> Status:
	agent.parent.left()
	return SUCCESS
