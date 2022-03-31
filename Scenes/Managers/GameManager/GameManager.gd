## The Root node for the game.
class_name GameManager
extends Node

onready var _world_grid := $WorldGrid

func _ready() -> void:
	_connect_to_signals()
	_game_loop()

func _connect_to_signals() -> void:
	for node in _get_entitys():
		var entity := node as Entity
		if entity is Entity:
			entity.connect("requested_move", self, "_on_requested_move")

func _game_loop() -> void:
	while true:
		yield(_play_round(), 'completed')
		yield(get_tree(), 'idle_frame')

func _play_round():
	for node in _get_entitys():
		var entity := node as Entity
		entity.round_update()
		if entity.can_act:
			var action : Action = yield(entity.play_turn(), "completed")
			action.do(_world_grid)

func _get_entitys() -> Array:
	return get_tree().get_nodes_in_group("entitys")
