extends GlobalEvent
class_name EventTourneyStart

func _init():
	event_text = "Wlecome to %s!"
	event_text += "\n%d players, %d rounds, and %d courses, with %d $ins up for grabs!"
	event_text += "\nGLOLF!! BY ANY MEANS NECESSARY."
	event_text_vars = ["the Tourney", 0, 0, 0, 0]

func do_event():
	var t = main_node.get_node("%League").new_tourney()
	event_text_vars = [
		t.tourney_name,
		t.all_players.size(),
		t.courses_per_round.size(),
		t.courses_per_round.reduce(func(accum, n): return accum + n),
		t.sin_reward
	]
	
	queue_event(EventNextRound.new())
	
	print(as_text())
	is_done(self)
