extends CharacterBody2D

@export var speed = 0.4

@onready var sprite_2d: Sprite2D = $Sprite2D

var direction: String = 'left'

func _physics_process(_delta: float) -> void:
	walk()

func walk():
	var displacement = speed
	
	if direction == 'left':
		displacement *= -1
	
	var x_positon = position.x + displacement
	
	position = Vector2(x_positon, position.y)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	
	body.kill()

func _on_area_2d_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area is not BichoDelimiter:
		return
	
	if direction == 'left':
		direction = 'right'
		sprite_2d.flip_h = true
	else:
		direction = 'left'
		sprite_2d.flip_h = false
