class_name HudLifes extends Control

@export var player: Player
@export var lifes: Array[TextureRect]

func _ready() -> void:
	if not player.is_node_ready():
		player.ready.connect(_connect_player)
		return
	
	_connect_player()

func _connect_player():
	player.health_controller.damage_received.connect(remove_lifes)
	player.health_controller.healed.connect(show_lifes)

func remove_lifes(_amount: int):
	for i in range(lifes.size()):
		if i > player.health_controller.health - 1:
			lifes[i].hide()

func show_lifes():
	for i in range(player.health_controller.health):
		lifes[i].show()
