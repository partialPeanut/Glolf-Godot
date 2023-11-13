extends LocalEvent
class_name EventAggression

var attacker:Player

func _init(_course_node:Node = null, _attacker:Player = null):
	super(_course_node)
	attacker = _attacker
	
	event_text = "%s just fucking attacked someone?"
	event_text_vars = ["Someone"]

func do_event():
	event_text_vars = [attacker.full_name()]
	display()
	is_done(self)
