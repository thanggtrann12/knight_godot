extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var swing : bool = false

@onready var animation_tree = $AnimationTree
@onready var health_bar = $HealthBar
@onready var satama_bar = $SatamaBar

@export var health: int = 100
@export var satama: int = 100
@export var tilemap: TileMap
@onready var is_dash: bool = false
@onready var speed: int = 100

func _ready():
	health_bar.max_value = health
	health_bar.value = health
	satama_bar.max_value = satama
	satama_bar.value = satama

func _physics_process(_delta):
	if not swing:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
func _process(_delta):
	satama += 1
	satama_bar.value = satama
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction != Vector2.ZERO and not swing:
		set_walking(true)
		update_blend_position()
	else:
		set_walking(false)
	
	if Input.is_action_just_pressed("swing"):
		set_swing(true)

func set_swing(value = false):
	swing = value
	animation_tree["parameters/conditions/swing"] = value

func set_walking(value):
	animation_tree["parameters/conditions/is_walking"] = value
	animation_tree["parameters/conditions/idle"] = not value

func update_blend_position():
	animation_tree["parameters/attack/blend_position"] = direction
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/walk/blend_position"] = direction

func take_damage(amount: int):
	health -= amount
	health_bar.value = health
	
	if health <= 0:
		get_tree().reload_current_scene()

func dash():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + velocity * 0.8, 0.45)
	await tween.finished
	
func _input(event):
	if event.is_action_pressed("dash"):
		if satama > 0:
			satama -= 20  # Reduce stamina by 10 when dashing
			satama_bar.value = satama
			dash()
	elif event.is_action_released("dash"):
		satama += 10  # Increase stamina by 10 when dash is released
		satama_bar.value = satama
