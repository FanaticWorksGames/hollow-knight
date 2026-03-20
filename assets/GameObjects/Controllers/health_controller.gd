class_name HealthController extends Node

@export var max_health = 12

var health = max_health

func receive_damage(damage: int):
	health -= damage
	
	if health <= 0:
		get_parent().queue_free()
