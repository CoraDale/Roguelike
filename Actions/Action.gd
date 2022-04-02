## Base class for Action objects.
##
## Inherits from Resource so that it is reference-tracked, can be serialized,
## and can export properties in the Inspector
class_name Action

func do(_world_grid: WorldGrid) -> Result:
	var result := Result.new(-1)
	printerr("action.do() was not overloaded")
	return result

func undo(_world_grid: WorldGrid) -> Result:
	var result := Result.new(-1)
	printerr("action.undo() was not overloaded")
	return result

class Result:
	## Result of an action, can be a success, failure, or can chain onto another Action to execute

	var ends_turn: bool
	var record_action : bool
	var cancel_chain: bool
	var chaining : bool

	var chained_action: Action

	func _init(end := true, record := false, cancel := false, next_action : Action = null):
		ends_turn = end
		record_action = record
		cancel_chain = cancel
		if next_action != null:
			set_chained_action(next_action)
		else:
			clear_chained_action()

	func set_end_turn(end: bool) -> void:
		ends_turn = end

	func set_cancel_chain(cancel: bool) -> void:
		cancel_chain = cancel

	func set_record_action(record: bool) -> void:
		record_action = record

	func set_chained_action(next_action: Action) -> void:
		chaining = true
		chained_action = next_action

	func clear_chained_action() -> void:
		chaining = false
		chained_action = null
