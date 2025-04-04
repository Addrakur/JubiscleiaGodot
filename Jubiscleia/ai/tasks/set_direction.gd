extends BTAction


func _tick(_delta: float) -> Status:
	var direction: float
	if agent.parent.position.x > agent.parent.player_ref.position.x:
		direction = -1
	else:
		direction = 1
	blackboard.set_var("direction",direction)
	return SUCCESS
