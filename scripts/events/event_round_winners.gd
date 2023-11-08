extends GlobalEvent
class_name EventRoundWinners

func _init():
	event_text = "Congratulations to the Round %d Winners: %s!"
	event_text_vars = [-1, "No one"]

func do_event():
	var tourney = main_node.get_node("%League/Tourney")
	var winners = tourney.get_winners()
	tourney.round_winners.append(winners)
	
	event_text_vars = [tourney.round_num+1, ", ".join(winners.map(func(p): return p.full_name()))]
	
	queue_event(EventRoundingOff.new())
	print(as_text())
	is_done(self)
