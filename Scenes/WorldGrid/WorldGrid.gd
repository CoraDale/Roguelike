## The World Grid which all tiles and entities are positioned on. Displays terrain tiles.
class_name WorldGrid
extends TileMap

func cell_has_collision(coords: Vector2) -> bool:
	return false

func _update_tiles(tiles: Array) -> void:
	for x in range(0, tiles.size()):
		for y in range(0, tiles[x].size()):
			set_cell(x, y, tiles[x][y].tile_index)
