extends BTAction

func _tick(_delta: float) -> Status:
	if agent.parent.target.position.x > agent.parent.position.x:
		agent.parent.right()
	else:
		agent.parent.left()
	return SUCCESS
