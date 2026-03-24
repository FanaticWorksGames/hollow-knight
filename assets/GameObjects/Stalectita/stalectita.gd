class_name Stalectita extends RigidBody2D

@export var detection_area: Area2D
@onready var damage_area: DamageArea = $DamageArea

func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	damage_area.body_entered.connect(_on_damage_area_body_entered)

func _on_detection_area_body_entered(_body: Node2D):
	call_deferred("unfreeze_stalactita")

func _on_damage_area_body_entered(body: Node2D):
	if body is TileMapLayer:
		print("FREEZE")
		call_deferred("freeze_stalactita")

func freeze_stalactita():
	freeze = true

func unfreeze_stalactita():
	freeze = false
	detection_area.body_entered.disconnect(_on_detection_area_body_entered)
	detection_area.queue_free()
