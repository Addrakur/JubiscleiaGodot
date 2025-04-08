extends BTAction

@export var value: Vector2

func _tick(_delta: float) -> Status:
	agent.parent.velocity = value
	return SUCCESS
