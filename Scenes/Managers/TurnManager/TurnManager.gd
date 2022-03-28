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

##This code is wip
func play_round():
	for node in get_children():
		var entity := node as Entity
		print("Turn: {turn} - Go {EntityName}".format({"turn": turn as String, "EntityName": entity.name}))
		turn += 1
		if entity:
			entity.round_update()
			if entity.can_act:
				var action = yield(entity.play_turn(), "completed")
