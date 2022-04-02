## Base class for Action objects.
##
## Inherits from Resource so that it is reference-tracked, can be serialized,
## and can export properties in the Inspector
class_name Action
extends Resource

func do(_world_grid: WorldGrid) -> ActionResult:
	var result := ActionResult.new(-1)
	printerr("action.do() was not overloaded")
	return result

func undo(_world_grid: WorldGrid) -> ActionResult:
	var result := ActionResult.new(-1)
	printerr("action.undo() was not overloaded")
	return result
