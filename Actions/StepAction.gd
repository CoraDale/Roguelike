## An action that attempts to move an entity 1 space.
class_name StepAction
extends Action

var entity: Entity
var direction: Vector2

func _init(entity: Entity, direction: Vector2) -> void:
	self.entity = entity
	self.direction = direction

func do(world_grid: WorldGrid) -> void:
	var cell_start := world_grid.world_to_map(entity.position)
	var cell_target := cell_start + direction
	
	if world_grid.cell_has_collision(cell_target):
		entity.move_result(false)
	else:
		entity.position = world_grid.map_to_world(cell_target)
		entity.move_result(true)

func undo(world_grid: WorldGrid) -> void:
	var cell_start := world_grid.world_to_map(entity.position)
	var cell_target := cell_start + direction.rotated(180)
	
	if world_grid.cell_has_collision(cell_target):
		entity.move_result(false)
	else:
		entity.position = world_grid.map_to_world(cell_target)
		entity.move_result(true)
