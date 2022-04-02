## Result of an action, can be a success, failure, or can chain onto another Action to execute
class_name ActionResult
extends Resource

var ends_turn: bool
var record_action : bool
var cancel_chain: bool
var chaining : bool

var chained_action

func _init(end := true, record := false, cancel := false, next_action = null):
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

func set_chained_action(next_action) -> void:
	chaining = true
	chained_action = next_action

func clear_chained_action() -> void:
	chaining = false
	chained_action = null
