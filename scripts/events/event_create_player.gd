extends GlobalEvent
class_name EventCreatePlayer

func _init():
	event_text = "%s wields their first club."
	event_text_vars = ["Someone"]
	
func do_event():
	var p = main_node.get_node("%Roster").create_new_player()
	event_text_vars = [p.full_name()]
	
	print(as_text())
	is_done(self)
