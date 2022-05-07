## Main root node that runs the game loop and actions.
class_name GameManager
extends Node

onready var _world_grid := $WorldGrid
onready var _action_runner := $ActionRunner

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
			var end_turn = _action_runner.perform_action(action)
			if end_turn:
				entity.can_act = false

func _get_entitys() -> Array:
	return get_tree().get_nodes_in_group("entitys")
