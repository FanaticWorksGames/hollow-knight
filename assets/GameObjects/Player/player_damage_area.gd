class_name PlayerDamageArea extends Area2D

@onready var player: Player = get_parent().get_parent().get_parent()

func _on_body_entered(body: Node2D) -> void:
	var health_controller: HealthController = body.get_node_or_null("HealthController")
	
	if health_controller:
		health_controller.receive_damage(4)
		if "getSoulTrue" in body:
			player.getSoul()
	
	player.knock_back()
	
	set_collision_layer_value(3, false) # Enemy
	set_collision_layer_value(5, false) # Wall
