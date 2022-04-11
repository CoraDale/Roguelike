## The World Grid which all tiles and entities are positioned on. Displays terrain tiles.
class_name WorldGrid
extends TileMap

var entity_dict := {}

func place_entities(entities: Array) -> void:
	for node in entities:
		var entity = node
		var coords = self.world_to_map(entity.position)
		if coords in entity_dict:
			var array : Array = entity_dict.get(coords)
			array.append(entity)
		else:
			var array := [entity]
			entity_dict[coords] = array

func cell_has_collision(_coords: Vector2) -> bool:
	return false

func _update_tiles(tiles: Array) -> void:
	for x in range(0, tiles.size()):
		for y in range(0, tiles[x].size()):
			set_cell(x, y, tiles[x][y].tile_index)
