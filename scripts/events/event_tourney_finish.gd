extends GlobalEvent
class_name EventTourneyFinish

func _init():
	event_text = "The tournament is over!! Congratulations to the winners: %s!!"
	event_text_vars = ["No one"]

func do_event():
	var tourney = main_node.get_node("%League/Tourney")
	var winners = tourney.get_winners()
	
	tourney.round_winners.append(winners)
	tourney.winners = winners
	
	event_text_vars = [", ".join(winners.map(func(p): return p.full_name()))]
	
	var league = main_node.get_node("%League")
	league.end_tourney()
	
	var mods = Mod.mods_of(tourney)
	for mod in mods:
		mod.on_tourney_finish(self)
	
	display()
	is_done(self)
