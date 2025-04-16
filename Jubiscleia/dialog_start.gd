extends Area2D

@export var timeline_name: String
@export var interactive: bool
@export var area_collision: CollisionShape2D
@export var can_repeat: bool

var not_repeated: bool = true

func player_on_area(body: Node2D):
	if not interactive and body is Player:
		if can_repeat or not_repeated:
			if body.is_on_floor():
				body.fsm.change_state(body.idle_state)
			else:
				body.fsm.change_state(body.fall_state)
			PlayerVariables.toggle_active_player(false)
			Dialogic.start(timeline_name)
			not_repeated = false
