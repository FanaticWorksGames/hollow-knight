class_name HUD_Soul extends Control

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@export var player: Player

func _ready() -> void:
	player.soulUpdated.connect(setSoul)

func setSoul(soulAmount: int) -> void:
	progress_bar.value = soulAmount
