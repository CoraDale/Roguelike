## An action that just prints a message to the console.
class_name PrintAction
extends Action

var message

func _init(message) -> void:
	self.message = message

func do(world_grid: WorldGrid) -> void:
	print(message)

func undo(world_grid: WorldGrid) -> void:
	print("Actually I take back %s" % message)
