extends GlobalEvent
class_name EventRoundingOff

func _init():
	event_text = "The Rounding Off has struck. %d players have been Truncated."
	event_text_vars = [-1]

func do_event():
	var tourney = main_node.get_node("%League/Tourney")
	var rn = tourney.round_num
	var start_amt = tourney.remaining_players.size()
	var open_slots = floori((start_amt * tourney.courses_per_round[rn+1]) / tourney.courses_per_round[rn])
	
	var at_risk = tourney.remaining_players.filter(func(p): return !p in tourney.round_winners[rn])
	at_risk.sort_custom(func(a, b): return tourney.get_info(a).score < tourney.get_info(b).score)
	
	tourney.remaining_players = tourney.round_winners[rn] + at_risk.slice(0, open_slots - tourney.round_winners.size())
	
	event_text_vars = [start_amt - tourney.remaining_players.size()]
	
	var mods = Mod.mods_of(tourney)
	for mod in mods:
		mod.on_the_culling(self)
	
	queue_event(EventNextRound.new())
	print(as_text())
	is_done(self)
