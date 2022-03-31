## Any non-terrain object with a cell-position on the worldgrid.
class_name Entity
extends Node2D

signal requested_move(entity, movement_goal)
signal has_movement_goal(movement_goal)

var _movement_goal := Vector2.ZERO
onready var _controller = $Controller

var can_act := true

func _ready() -> void:
	add_to_group("entitys")
	_controller.set_entity(self)

func round_update() -> void:
	can_act = true

func play_turn() -> Action:
	can_act = false
	var action : Action = yield(_controller, 'has_selected_action')
	return action
