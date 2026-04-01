extends CharacterBody2D

const GEO = preload("uid://4v3gvawys33e")
var geoCout = 4

func drop_geo() -> void:
	for i in geoCout:
		var geo = GEO.instantiate() as RigidBody2D
		get_tree().current_scene.add_child(geo)
		geo.global_position = global_position

func _on_health_controller_died() -> void:
	call_deferred("drop_geo")
