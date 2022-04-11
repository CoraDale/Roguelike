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

# Moving an entity will require not only adding it to the new location's entity array, but also
# Removing it from the entity array of its current location. Finding an entity in a location's
# Entity array will be quite slow IF there are many entities in the array. A possible option would
# be to use location entity dictionaries that have ids for each entity. Each entity then needs to store
# and manage its own id. This could be useful, and wouldn't be hard to implement by just giving them
# each unique names and using the name as the id. However it probably isn't neccessary in this case since
# There will not normally be many entities in a single place.
func move_entity(entity, )

func cell_has_collision(_coords: Vector2) -> bool:
	return false

func _update_tiles(tiles: Array) -> void:
	for x in range(0, tiles.size()):
		for y in range(0, tiles[x].size()):
			set_cell(x, y, tiles[x][y].tile_index)
