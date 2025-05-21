extends BTAction

func _tick(_delta: float) -> Status:
	var dir = blackboard.get_var("direction")
	agent.parent.velocity.x = agent.speed * dir * agent.parent.speed
	return SUCCESS
