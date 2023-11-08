extends LocalEvent
class_name EventPlayerTurnResult

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "No dice."
	event_text_vars = []

func do_event():
	var current_player = course_node.active_players[course_node.player_num]
	var mods = Mod.mods_of(current_player)
	
	if randi() % 2 == 0:
		course_node.player_info[current_player].sunk = true
		event_text = "They nailed it!!"
		
		for mod in mods:
			mod.on_sink(self, current_player)
	
	var next_player = course_node.find_unsunk_player_after(course_node.player_num)
	if course_node.find_unsunk_player_after(-1) == -1:
		queue_event(EventHoleFinish.new(course_node))
	elif next_player == -1:
		queue_event(EventUpTop.new(course_node))
	else:
		queue_event(EventPlayerTurn.new(course_node))
	
	for mod in mods:
		mod.on_player_turn_result(self, current_player)
	
	course_node.try_random_events(current_player.autism)
	
	print(as_text())
	is_done(self)
