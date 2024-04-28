extends Camera2D

@onready var tilemap : TileMap = owner.tilemap


# Called when the node enters the scene tree for the first time.
func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizePixels = mapRect.size * tileSize
	limit_right = worldSizePixels.x
	limit_bottom = worldSizePixels.y

