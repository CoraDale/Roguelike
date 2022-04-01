## An action that attempts to move an entity 1 space.
class_name StepAction
extends Action

var _entity
var _direction: Vector2

func _init(entity, direction: Vector2) -> void:
	self._entity = entity
	self._direction = direction

func do(world_grid: WorldGrid) -> ActionResult:
	var cell_start := world_grid.world_to_map(_entity.position)
	var cell_target := cell_start + _direction
	var result = ActionResult.new()
	
	if world_grid.cell_has_collision(cell_target):
		result.set_record_action(true)
		result.set_end_turn(false)
	else:
		_entity.position = world_grid.map_to_world(cell_target)
		result.set_record_action(true)
		result.set_end_turn(true)
	return result

func undo(world_grid: WorldGrid) -> ActionResult:
	var cell_start := world_grid.world_to_map(_entity.position)
	var cell_target := cell_start + _direction.rotated(180)
	var result = ActionResult.new()
	
	if world_grid.cell_has_collision(cell_target):
		result.set_record_action(true)
		result.set_end_turn(false)
	else:
		_entity.position = world_grid.map_to_world(cell_target)
		result.set_record_action(true)
		result.set_end_turn(true)
	return result
