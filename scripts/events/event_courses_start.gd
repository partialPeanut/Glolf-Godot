extends GlobalEvent
class_name EventNextRound

func _init():
	event_text = "Round %d. %d divisions begin play."
	event_text_vars = [-1, -1]

func do_event():
	var tourney = main_node.get_node("%League/Tourney")
	tourney.round_num += 1
	tourney.initialize_courses(tourney.round_num)
	
	event_text_vars = [tourney.round_num+1, tourney.courses.size()]
	
	var mods = Mod.mods_of(tourney)
	for mod in mods:
		mod.on_next_round(self)
	
	for c in tourney.courses:
		queue_event_immediately(EventCourseStart.new(c))
	print(as_text())
	is_done(self)
