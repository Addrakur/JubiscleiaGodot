extends BTAction

func _tick(_delta: float) -> Status:
	if agent.parent.target == agent.parent.player_ref:
		return SUCCESS
	else:
		return FAILURE
