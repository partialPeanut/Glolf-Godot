extends Node
class_name GlobalEvent

static var main_node: Node

var event_text = "---"
var event_text_vars = []
var characters_involved = []

func _ready():
	if main_node == null:
		main_node = get_node("/root/Main")

func do_event():
	is_done(self)

func display():
	print(as_text())

func as_text():
	return event_text % event_text_vars

func is_done(node:Node):
	main_node.get_node("%Onceler").on_event_complete(node)

func queue_event(e):
	main_node.get_node("%Onceler").queue_event(e)

func queue_event_immediately(e):
	main_node.get_node("%Onceler").queue_event_immediately(e)
