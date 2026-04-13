class_name DamageArea extends Area2D

@export var damage: int = 1

@export_group("Settings")
@export var _disable_on_hit: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	var health_controller: HealthController = body.get_node_or_null("HealthController")
	
	if health_controller:
		health_controller.receive_damage(damage)
	
	if _disable_on_hit:
		set_collision_mask_value(3, false) # Enemy
		set_collision_mask_value(5, false) # Wall
		set_collision_mask_value(1, false) # Player
