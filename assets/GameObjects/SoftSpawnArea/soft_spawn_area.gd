class_name SoftSpawnArea extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	var player: Player = body
	player.set_soft_spawn_point(position)
