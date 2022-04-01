## An action that prints multiple messages to test chaining.
class_name ChainPrintAction
extends Action

var _messages: Array

func _init(messages: Array) -> void:
	self._messages = messages

func do(_world_grid: WorldGrid) -> ActionResult:
	var result = ActionResult.new()
	print(_messages.pop_back())
	var next_action = PrintAction.new("")
	result.set_record_action(false)
	result.set_end_turn(false)
	result.set_chained_action(next_action)
	return result

func undo(_world_grid: WorldGrid) -> ActionResult:
	var result = ActionResult.new()
	print(_messages.pop_front())
	result.set_record_action(false)
	result.set_end_turn(false)
	return result
