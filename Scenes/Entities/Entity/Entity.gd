## Any non-terrain object with a cell-position on the worldgrid.
class_name Entity
extends Node2D

signal requested_move(entity, movement_goal)
signal has_movement_goal(movement_goal)

var _movement_goal := Vector2.ZERO

var can_act := true
var components := { "inputHandler": InputComponent.new() }

func _ready() -> void:
	add_to_group("entitys")

func _input(_event: InputEvent) -> void:
		_movement_goal = components.inputHandler.determine_movement_goal()
		if _movement_goal != Vector2.ZERO:
			emit_signal("has_movement_goal", _movement_goal)

func round_update() -> void:
	if self.can_act:
		yield (play_turn(), 'completed')

func play_turn() -> void:
	yield(self, "has_movement_goal")
	emit_signal("requested_move", self, _movement_goal)

func _movement_result(success: bool) -> void:
	_movement_goal = Vector2.ZERO
