extends Area2D

@export var itens: Array[Node]


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		for item in itens:
			item.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		for item in itens:
			item.visible = false
