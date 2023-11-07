extends GlobalEvent
class_name EventNextRound

func _init():
	event_text = "Round %d. %d divisions begin play."
	event_text_vars = [-1, -1]

func do_event():
	var tourney = main_node.get_node("%League/Tourney")
	tourney.initialize_courses(tourney.round_num)
	
	for c in tourney.courses:
		queue_event_immediately(EventCourseStart.new(c))
	
	event_text_vars = [tourney.round_num+1, tourney.courses.size()]
	print(as_text())
	is_done(self)
