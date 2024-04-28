extends Node2D
@onready var left = $Left
@onready var right = $Right
@onready var left_label = $Left/CollisionShape2D/Label
@onready var right_label = $Right/CollisionShape2D/Label


func _process(_delta):
	var left_distance = ($"../player".position - left.position).length()
	var right_distance = ($"../player".position - right.position).length()
	if left_distance > 50:
		left_label.visible = false
	if left_distance < 50 and left_distance > 30:
		left_label.visible = true
		left_label.text = "!"
	elif left_distance < 30:
		left_label.text = "South Forest"
	
	if right_distance > 50:
		right_label.visible = false
	elif right_distance < 50 and right_distance > 30:
		right_label.visible = true
		right_label.text = "!"
	elif right_distance < 30:
		right_label.text = "North Forest"
