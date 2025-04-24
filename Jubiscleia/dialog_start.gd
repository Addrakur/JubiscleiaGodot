extends Area2D

@export var timeline_name: String

@export var area_collision: CollisionShape2D
@export var can_repeat: bool
@export var area: bool
@export var enemy_killed: bool
@export var enemy_alive: bool
@export var object_picked: bool
@export var item_interacted: bool
@export var item_not_interacted: bool

@export var enemies: Array[Node2D]
@export var objects: Array[Node2D]
@export var items: Array[Node2D]

var not_repeated: bool = true

func player_on_area(body: Node2D):
	if area and body is Player:
		if can_repeat or not_repeated and can_start_dialog():
			start_dialog()

func _process(_delta: float) -> void:
	if area:
		return
	
	if can_repeat or not_repeated and can_start_dialog():
		start_dialog()
	
func start_dialog():
	var player = GameSettings.player
	player.velocity.x = 0
	if player.is_on_floor():
		player.fsm.change_state(player.idle_state)
	elif player.fsm.state != player.fall_state:
		player.fsm.change_state(player.fall_state)
	PlayerVariables.toggle_active_player(false)
	Dialogic.start(timeline_name)
	not_repeated = false

func can_start_dialog() -> bool:
	if enemy_killed:
		for enemy in enemies:
			if enemy != null:
				if enemy.alive:
					return false
	
	if enemy_alive:
		for enemy in enemies:
			if enemy != null:
				if not enemy.alive:
					return false
	
	if object_picked and not objects.is_empty():
		return false
	
	if item_interacted:
		for item in items:
			if item != null:
				if not item.interacted:
					return false
	
	if item_not_interacted:
		for item in items:
			if item != null:
				if item.interacted:
					return false
	
	return true
