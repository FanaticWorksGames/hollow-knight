class_name SoftRespawnDamageArea extends Area2D

@export var damage: int = 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	var player: Player = body
	
	player.health_controller.receive_damage(damage)
	player.soft_respawn()
