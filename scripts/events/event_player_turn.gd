extends LocalEvent
class_name EventPlayerTurn

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "%s takes a swing..."
	event_text_vars = ["Someone"]

func do_event():
	course_node.player_num = course_node.find_unsunk_player_after(course_node.player_num)
	var current_player = course_node.active_players[course_node.player_num]
	
	course_node.player_info[current_player].strokes += 1
	event_text_vars = [ current_player.full_name() ]
	
	var mods = Mod.mods_of(current_player)
	for mod in mods:
		mod.on_player_turn_start(self, current_player)
	
	queue_event_immediately(EventPlayerTurnResult.new(course_node))
	display()
	is_done(self)
