class_name HUD_Geo extends Control

@onready var label: Label = $HBoxContainer/Label
@export var player: Player

func _ready() -> void:
	player.geoCollected.connect(setGeo)

func setGeo(num: int) -> void:
	label.text = str(num)

func addGeo(num: int) -> void:
	label.text = str(label.text.to_int() + num)

func countGeo() -> int:
	return label.text.to_int()

func resetGeo() -> int:
	var aux = label.text.to_int()
	label.text = "0"
	return aux
