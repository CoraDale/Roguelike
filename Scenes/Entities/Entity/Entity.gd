## Any non-terrain object with a cell-position on the worldgrid.
class_name Entity
extends Node2D

signal requested_move(entity, movement_goal)

var _is_my_turn := true
var _movement_goal := Vector2.ZERO

func _ready() -> void:
	add_to_group("entitys")

func _input(_event: InputEvent) -> void:
	if(_is_my_turn):
		_movement_goal = _get_movement_goal()

func _physics_process(delta: float) -> void:
	_take_turn()

func _movement_result(success: bool) -> void:
	if success:
		print("I moved")
	else:
		print("bump")
	_movement_goal = Vector2.ZERO

func _take_turn() -> void:
	if _movement_goal:
		emit_signal("requested_move", self, _movement_goal)

func _get_movement_goal() -> Vector2:
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("move_north"):
		direction.y -= 1
	if Input.is_action_pressed("move_south"):
		direction.y += 1
	if Input.is_action_pressed("move_west"):
		direction.x -= 1
	if Input.is_action_pressed("move_east"):
		direction.x += 1
	if Input.is_action_pressed("move_northwest"):
		direction.y -= 1
		direction.x -= 1
	if Input.is_action_pressed("move_northeast"):
		direction.y -= 1
		direction.x += 1
	if Input.is_action_pressed("move_southwest"):
		direction.y += 1
		direction.x -= 1
	if Input.is_action_pressed("move_southeast"):
		direction.y += 1
		direction.x += 1
		
	direction.y = clamp(direction.y, -1, 1)
	direction.x = clamp(direction.x, -1, 1) 
	return direction
