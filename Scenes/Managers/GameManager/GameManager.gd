## The Root node for the game.
class_name GameManager
extends Node

onready var WorldGrid := $WorldGrid

func _ready() -> void:
	_connect_to_signals()
	_game_loop()

func _connect_to_signals() -> void:
	var entitys := get_tree().get_nodes_in_group("entitys")
	for node in entitys:
		var entity := node as Entity
		if entity is Entity:
			entity.connect("requested_move", self, "_on_requested_move")

func _game_loop() -> void:
	while true:
		yield(_play_round(), 'completed')
		yield(get_tree(), 'idle_frame')

func _play_round():
	for node in get_tree().get_nodes_in_group("entitys"):
		var entity := node as Entity
		if entity:
			entity.round_update()
			if entity.can_act:
				var action = yield(entity.play_turn(), "completed")

func _on_requested_move(entity: Entity, movement_goal: Vector2) -> void:
	var cell_start : Vector2 = WorldGrid.world_to_map(entity.position)
	var cell_target := cell_start + movement_goal
	
	if WorldGrid.cell_has_collision(cell_target):
		entity.call("_movement_result", false)
	else:
		entity.position = WorldGrid.map_to_world(cell_target)
		entity.call("_movement_result", true)
