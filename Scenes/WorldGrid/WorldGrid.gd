## The World Grid which all tiles and entities are positioned on. Displays terrain tiles.
class_name WorldGrid
extends TileMap

var entity_dict := {}

func place_entities(entities: Array) -> void:
	for node in entities:
		var entity = node
		var coords = world_to_map(entity.position)
		add_entity_to_position(entity, coords)

func add_entity_to_position(entity: Node, coords: Vector2) -> void:
	if coords in entity_dict:
		var array : Array = entity_dict.get(coords)
		array.append(entity)
	else:
		var array := [entity]
		entity_dict[coords] = array

func remove_entity_from_position(entity: Node, coords: Vector2) -> void:
	entity_dict.get(coords).erase(entity)
	if entity_dict.get(coords).empty():
		entity_dict.erase(coords)

# Moving an entity will require not only adding it to the new location's entity array, but also
# Removing it from the entity array of its current location. Finding an entity in a location's
# Entity array will be quite slow IF there are many entities in the array. A possible option would
# be to use location entity dictionaries that have ids for each entity. Each entity then needs to store
# and manage its own id. This could be useful, and wouldn't be hard to implement by just giving them
# each unique names and using the name as the id. However it probably isn't neccessary in this case since
# There will not normally be many entities in a single place.
func move_entity(entity: Node, cell_target: Vector2) -> void:
	remove_entity_from_position(entity, world_to_map(entity.position))
	add_entity_to_position(entity, cell_target)
	entity.position = map_to_world(cell_target)
	print(entity_dict)

func cell_has_collision(coords: Vector2) -> bool:
	var entity_array = entity_dict.get(coords, [])
	if entity_array.empty():
		return false
	else:
		return true

func _update_tiles(tiles: Array) -> void:
	for x in range(0, tiles.size()):
		for y in range(0, tiles[x].size()):
			set_cell(x, y, tiles[x][y].tile_index)
