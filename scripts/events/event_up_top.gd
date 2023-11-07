extends LocalEvent
class_name EventUpTop

func _init(_course_node:Node):
	super(_course_node)
	event_text = "The cycle begins anew. %d players are still swinging."
	event_text_vars = [-1]

func do_event():
	course_node.player_num = course_node.find_unsunk_player_after(-1)
	
	event_text_vars = [course_node.players.filter(func(p): return !course_node.player_info[p].sunk).size()]
	
	queue_event(EventPlayerTurn.new(course_node))
	print(as_text())
	is_done(self)
