## Base class for Action objects.
##
## Inherits from Resource so that it is reference-tracked, can be serialized,
## and can export properties in the Inspector
class_name Action
extends Resource

func do() -> void:
	pass

func undo() -> void:
	pass
