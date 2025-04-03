extends BTAction

func _tick(_delta:float) -> Status:
	if agent.parent.player_on_limit:
		return SUCCESS
	else:
		return FAILURE
