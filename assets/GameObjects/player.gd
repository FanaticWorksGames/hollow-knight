class_name Player extends CharacterBody2D

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -200.0
const ATTACK_LEFT = preload("uid://vc68yhltylc4")
const ATTACK_RIGHT = preload("uid://bfp3eugthmg5o")
const ATTACK_UP = preload("uid://de7hmjxjkjirs")
const ATTACK_POGO = preload("uid://bpvgfb6hih3o1")

var last_dir_looked = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x != 0:
		last_dir_looked = velocity.x
	
	move_and_slide()

	if Input.is_action_just_pressed("ui_attack"):
		if Input.is_action_pressed("ui_down"):
			add_child(ATTACK_POGO.instantiate(), true)
		elif Input.is_action_pressed("ui_up"):
			add_child(ATTACK_UP.instantiate(), true)
		elif last_dir_looked < 0:
			add_child(ATTACK_LEFT.instantiate(), true)
		elif last_dir_looked > 0:
			add_child(ATTACK_RIGHT.instantiate(), true)

func kill():
	print_debug("You ded :(")
	var x_position: float = -110.0
	var y_position: float = -2.0
	
	position = Vector2(x_position, y_position)
