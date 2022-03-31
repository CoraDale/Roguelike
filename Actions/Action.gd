## Base class for Action objects.
##
## Inherits from Resource so that it is reference-tracked, can be serialized,
## and can export properties in the Inspector
class_name Action
extends Resource

func do(world_grid: WorldGrid) -> void:
	pass

func undo(world_grid: WorldGrid) -> void:
	pass
