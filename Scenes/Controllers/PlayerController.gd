## Entity Controller which takes player input to decide on actions.
class_name PlayerController
extends Node

signal has_selected_action(action)
var _entity: Entity

func _input(event: InputEvent) -> void:
	var action := select_action(event)
	if action:
		emit_signal("has_selected_action", action)

func initialize(entity: Entity) -> void:
	_entity = entity

func select_action(event: InputEvent) -> Action:
	var action: Action = null
	if event.is_action_pressed("ui_select"):
		action = PrintAction.new("%s says something unclear" % [_entity])
	if event.is_action_pressed("ui_focus_next"):
		action = ChainPrintAction.new(["Chain message 1", "Chain message 2"])
	else:
		var direction := _determine_movement_goal()
		if direction != Vector2.ZERO:
			action = StepAction.new(_entity, direction)
	return action

func get_selected_action() -> Action:
	var action : Action = yield(self, "has_selected_action")
	return action

func _determine_movement_goal() -> Vector2:
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
