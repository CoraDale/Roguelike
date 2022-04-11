## Main root node that runs the game loop and actions.
class_name GameManager
extends Node

onready var _world_grid := $WorldGrid

var action_history := []

func _ready() -> void:
	_game_loop()
	_world_grid.place_entities(_get_entitys())
	print(_world_grid.entity_dict)

func _game_loop() -> void:
	while true:
		yield(_play_round(), 'completed')
		yield(get_tree(), 'idle_frame')

func _play_round() -> void:
	for node in _get_entitys():
		var entity := node as Entity
		entity.round_update()
		while entity.can_act:
			var action : Action = yield(entity.play_turn(), "completed")
			var end_turn = _perform_action(action)
			if end_turn:
				entity.can_act = false

func _perform_action(action: Action) -> bool:
	var action_chain := []
	var result := action.do(_world_grid)
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

func _get_entitys() -> Array:
	return get_tree().get_nodes_in_group("entitys")
