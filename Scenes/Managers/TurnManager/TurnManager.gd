# This manager tracks turn order and manages what entity acts on the current turn
class_name TurnManager
extends Node

onready var active_character: Entity

var turn := 0
var waiting_for_action = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  initialize()

func initialize() -> void:
	active_character = get_child(0)

func play_turn():
	if not waiting_for_action:
		waiting_for_action = true
		print("Turn: {turn} - Go {EntityName}".format({"turn": turn as String, "EntityName": active_character.name}))
		yield(active_character.play_turn(), "completed")
		var new_index : int = (active_character.get_index() + 1) % get_child_count()
		active_character = get_child(new_index)
		turn += 1
		waiting_for_action = false
