extends Area2D

@onready var dungeon_path = "path"
func _on_body_entered(body):
	if body.is_in_group("player"):
		print(dungeon_path)
