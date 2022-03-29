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
		if entity is Entity:
			var action = yield(entity.round_update(), "completed")

func _get_entitys() -> Array:
	return get_tree().get_nodes_in_group("entitys")


func _on_requested_move(entity: Entity, movement_goal: Vector2) -> void:
	var cell_start : Vector2 = _world_grid.world_to_map(entity.position)
	var cell_target := cell_start + movement_goal
	
	if _world_grid.cell_has_collision(cell_target):
		entity.call("_movement_result", false)
	else:
		entity.position = _world_grid.map_to_world(cell_target)
		entity.call("_movement_result", true)
