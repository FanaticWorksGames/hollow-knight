class_name Player extends CharacterBody2D

var geo = 0

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -200.0
@export var KNOCKBACK_STRENGTH = 100.0
@export var POGO_STRENGTH = 250.0

@onready var health_controller: HealthController = $HealthController
signal geoCollected(totalGeo: int)

const ATTACK_LEFT = preload("uid://vc68yhltylc4")
const ATTACK_RIGHT = preload("uid://bfp3eugthmg5o")
const ATTACK_UP = preload("uid://de7hmjxjkjirs")
const ATTACK_POGO = preload("uid://bpvgfb6hih3o1")

var last_dir_looked: int = 1 # -1 LEFT / 1 RIGHT
var last_dir_attacked: Vector2 = Vector2.RIGHT

var knockback_force: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
var knockback_duration: float = 0.1

func _ready() -> void:
	health_controller.damage_received.connect(_get_damage)
	health_controller.died.connect(kill)

func _unhandled_input(_event: InputEvent) -> void:
	# Attack
	if Input.is_action_just_pressed("ui_attack"):
		# DOWN (POGO)
		if Input.is_action_pressed("ui_down") and not is_on_floor():
			last_dir_attacked = Vector2.DOWN
			add_child(ATTACK_POGO.instantiate(), true)
		
		# UP
		elif Input.is_action_pressed("ui_up"):
			last_dir_attacked = Vector2.UP
			add_child(ATTACK_UP.instantiate(), true)
		
		# LEFT
		elif last_dir_looked < 0:
			last_dir_attacked = Vector2.LEFT
			add_child(ATTACK_LEFT.instantiate(), true)
		
		# RIGHT
		else:
			last_dir_attacked = Vector2.RIGHT
			add_child(ATTACK_RIGHT.instantiate(), true)

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Knockback
	if knockback_timer > 0:
		knockback_timer -= delta
	else:
		# Movement
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if velocity.x != 0:
			last_dir_looked = sign(velocity.x)
		
		# Jump
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
	# Apply knockback once
	if knockback_force != Vector2.ZERO and last_dir_attacked == Vector2.DOWN:
		velocity.y = knockback_force.y
		knockback_force = Vector2.ZERO
	elif knockback_force != Vector2.ZERO:
		velocity += knockback_force
		knockback_force = Vector2.ZERO
	
	move_and_slide()

func _get_damage(_damage: int):
	prints("Player damaged. Life left: ", health_controller.health)
	knock_back()

func knock_back():
	var strength = KNOCKBACK_STRENGTH
	
	# POGO
	if last_dir_attacked == Vector2.DOWN:
		strength = POGO_STRENGTH
	
	knockback_force = -last_dir_attacked * strength
	
	knockback_timer = knockback_duration

func kill():
	print_debug("You ded :(")
	position = Vector2(-110.0, -2.0)
	health_controller.heal_full()


func _on_collection_area_body_entered(body: Node2D) -> void:
	var detectedGeo: Geo = body
	geo += detectedGeo.value
	detectedGeo.collected()
	geoCollected.emit(geo)
