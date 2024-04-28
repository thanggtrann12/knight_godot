extends Area2D

@onready var inside_spawn_room = "res://scenes/Room/InsideSpawnRoom/Scenes/InsideSpwanRoom.tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(inside_spawn_room)
