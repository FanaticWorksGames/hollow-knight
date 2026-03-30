class_name Geo extends RigidBody2D

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
var value: int = 1

func _ready() -> void:
	var force = randf_range(250, 350)
	var degree_variation = 20.0
	
	var angle = deg_to_rad(-90 + randf_range(-degree_variation, degree_variation))
	var direction = Vector2(cos(angle), sin(angle))
	linear_velocity = direction * force

func collected() -> void:
	audio.play()
	hide()

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
