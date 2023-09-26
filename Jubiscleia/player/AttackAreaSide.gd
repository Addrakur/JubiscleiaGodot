extends CollisionShape2D

@onready var lifetime: Timer = $Lifetime
@onready var player: Node2D = get_parent().get_parent()

func _process(delta):
	if disabled:
		return
	
	lifetime.start()

func on_attack_area_entered(body):
	var damage:float = player.damage
