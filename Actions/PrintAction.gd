## An action that just prints a message to the console.
class_name PrintAction
extends Action

var _message: String

func _init(message: String) -> void:
	self._message = message

func do(_world_grid: WorldGrid) -> Result:
	var result := Result.new()
	print(_message)
	result.set_record_action(false)
	result.set_end_turn(false)
	return result

func undo(_world_grid: WorldGrid) -> Result:
	var result := Result.new()
	print("Actually I take back %s" % _message)
	result.set_record_action(false)
	result.set_end_turn(false)
	return result
