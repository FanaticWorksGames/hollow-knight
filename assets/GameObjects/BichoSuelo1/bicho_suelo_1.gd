extends CharacterBody2D

@export var speed = 0.4

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_controller: HealthController = $HealthController
@onready var delimiter_area_2d: Area2D = $DelimiterArea2D
@onready var delimiter_area_2d_2: Area2D = $DelimiterArea2D2

var direction: String = 'left'

func _ready() -> void:
	delimiter_area_2d.area_shape_entered.connect(_on_area_2d_area_shape_entered)
	delimiter_area_2d_2.area_shape_entered.connect(_on_area_2d_area_shape_entered)

func _physics_process(_delta: float) -> void:
	walk()

func walk():
	var displacement = speed
	
	if direction == 'left':
		displacement *= -1
	
	var x_positon = position.x + displacement
	
	position = Vector2(x_positon, position.y)

func _on_area_2d_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area is not BichoDelimiter:
		return
	
	if direction == 'left':
		direction = 'right'
		animated_sprite_2d.flip_h = true
	else:
		direction = 'left'
		animated_sprite_2d.flip_h = false
