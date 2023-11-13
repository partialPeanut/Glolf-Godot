extends LocalEvent
class_name EventUpTop

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "The cycle begins anew. %d players are still swinging."
	event_text_vars = [-1]

func do_event():
	course_node.player_num = course_node.find_unsunk_player_after(-1)
	
	event_text_vars = [course_node.all_unsunk_players().size()]
	
	var mods = Mod.mods_of(course_node)
	for mod in mods:
		mod.on_up_top(self)
	
	queue_event(EventPlayerTurn.new(course_node))
	display()
	is_done(self)
