class_name HealthController extends Node

@export var max_health = 12
@export var remove_on_dead: bool = false

@onready var health = max_health

signal damage_received(damage: int)
signal died
signal healed

func receive_damage(damage: int):
	health -= damage
	damage_received.emit(damage)
	
	if health > 0:
		return
	
	died.emit()
	if remove_on_dead:
		owner.queue_free()

func heal(amount: int):
	health += amount
	
	if health > max_health:
		health = max_health
	
	healed.emit()

func heal_full():
	health = max_health
	healed.emit()
