extends Node2D

func _ready():
	var map_rect = get_node("Tile").get_used_rect()
	var tile_size = get_node("Tile").cell_quadrant_size
	var world_size_pixel = map_rect.size * tile_size
	get_node("../Player/FollowCam").limit_right = world_size_pixel.x - 20
	get_node("../Player/FollowCam").limit_bottom = world_size_pixel.y - 20
	get_node("../Player").position.x = 500
	get_node("../Player").position.y = 500
