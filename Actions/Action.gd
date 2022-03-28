## Base class for Action objects.
##
## Inherits from Resource so that it is reference-tracked, can be serialized,
## and can export properties in the Inspector
class_name Action
extends Resource


#signal signal_name(parameter: Type)
#enum enum_name { VALUE }
#const CONST_NAME: Type
#export var var_name: Type
#var public_variable: Type
#var _private_variable: Type
#onready var onready_variable: Type


# Constructor
#func _init(args).(parent_args) -> void:

func do() -> void:
	pass

func undo() -> void:
	pass

#func public_method(arg: Type) -> Type:


#func _private_method(arg: Type) -> Type:
