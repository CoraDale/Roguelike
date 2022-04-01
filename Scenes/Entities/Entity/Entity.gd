## Any non-terrain object with a cell-position on the worldgrid.
class_name Entity
extends Node2D

var _movement_goal := Vector2.ZERO
onready var _controller = $Controller

var can_act := true

func _ready() -> void:
	add_to_group("entitys")
	_controller.initialize(self)

func round_update() -> void:
	can_act = true

func play_turn() -> Action:
	var action : Action = yield(_controller, 'has_selected_action')
	return action

func move_result(moved: bool) -> void:
	if moved:
		print('I moved')
	else:
		print('bump')
