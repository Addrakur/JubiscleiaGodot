extends BTAction

@export var anim_name: String

func _tick(_delta: float) -> Status:
	agent.parent.animation.play(anim_name,-1, agent.parent.speed,false)
	return SUCCESS
