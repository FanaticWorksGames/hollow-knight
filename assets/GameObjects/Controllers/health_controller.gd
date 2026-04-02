class_name HealthController extends Node

@export var max_health = 5
@export var remove_on_dead: bool = false

@onready var health = max_health

signal damage_received(damage: int)
signal died
signal healed

func _ready() -> void:
	healed.emit(health, max_health)

func receive_damage(damage: int):
	health -= damage
	damage_received.emit(damage)
	#Me esto haciendo un puto lio con las signals de damagerecived que flipas
	#asi que vo ya usar la de healed para updatear el hud
	healed.emit(health, max_health)
	
	if health > 0:
		return
	
	died.emit()
	if remove_on_dead:
		owner.queue_free()

func heal(amount: int):
	health += amount
	
	if health > max_health:
		health = max_health
	
	healed.emit(health, max_health)

func heal_full():
	health = max_health
	healed.emit(health, max_health)
