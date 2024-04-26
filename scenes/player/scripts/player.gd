extends CharacterBody2D

# Variables
var direction: Vector2 = Vector2.ZERO
var swing: bool = false
var speed: int = 200
var health: int = 100

# References
@onready var animation_tree = $AnimationTree
@onready var health_bar = $HealthBar
@onready var hit_box = $Hand/HitBox

func _ready():
	# Initialize health bar
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(_delta):
	# Movement logic
	if not swing:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(_delta):
	# Input handling
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if direction != Vector2.ZERO and not swing:
		set_movement_animation(true)
	else:
		set_movement_animation(false)

	if Input.is_action_just_pressed("swing"):
		set_swing(true)

func set_swing(value=false):
	# Set swing animation
	swing = value
	animation_tree["parameters/conditions/swing"] = value
	hit_box.get_child(0).set_disabled(value)

func set_movement_animation(is_walking):
	# Set movement animation
	animation_tree["parameters/conditions/is_walking"] = is_walking
	animation_tree["parameters/conditions/idle"] = not is_walking
	animation_tree["parameters/attack/blend_position"] = direction
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/walk/blend_position"] = direction

func attacking():
	pass  # Unused function

func take_damage(damage: int):
	# Damage handling
	health -= damage
	health_bar.value = health
	if health <= 0:
		owner.get_tree().reload_current_scene()
	else:
		call_deferred("_process", get_physics_process_delta_time())

func _on_hit_box_body_entered(body):
	# Handle collision with other bodies
	if swing and body.is_in_group("enemy"):
		body.take_damage(10)
