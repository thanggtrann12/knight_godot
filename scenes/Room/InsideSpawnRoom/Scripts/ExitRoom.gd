extends Area2D

@onready var previous_room = "res://scenes/Room/SpawnRoom/Scenes/SpawnRoom.tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file(previous_room)
