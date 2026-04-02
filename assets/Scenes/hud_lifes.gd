class_name HudLifes extends Control

@export var player: Player
@export var lifes: Array[TextureProgressBar]

func _ready() -> void:
	update_hud(5, 5)
	if not player.is_node_ready():
		player.ready.connect(_connect_player)
		return
	
	_connect_player()

func _connect_player():
	player.health_controller.healed.connect(update_hud)

func update_hud(health: int, maxHealth: int) -> void:
	var i = 1
	for life in lifes:
		if i <= maxHealth:
			life.show()
		else:
			life.hide()
		if i <= health:
			life.value = 1
		else:
			life.value = 0
		i += 1
