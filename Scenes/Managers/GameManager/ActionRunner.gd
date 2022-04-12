## Handles running actions and storing them in action history.
class_name ActionRunner
extends Node

export var _world_grid : NodePath

var action_history := []

func perform_action(action: Action) -> bool:
	var action_chain := []
	var result := action.do(get_node(_world_grid))
	var chaining := true
	while chaining:
		if result.record_action:
			action_chain.append(action)
		if result.chaining:
			var new_action = result.chained_action
			result = new_action.do(_world_grid)
		else:
			chaining = false
		if	result.cancel_chain:
			action_chain = []
	action_history.append_array(action_chain)
	return result.ends_turn
