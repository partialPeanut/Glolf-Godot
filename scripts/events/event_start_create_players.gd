extends GlobalEvent
class_name EventStartCreatePlayers

var num_players: int

func _init(_num_players:int = 96):
	num_players = _num_players
	
	event_text = "Contracts signed. %d players rise from the ground."
	event_text_vars = [_num_players]

func do_event():
	for i in num_players:
		queue_event_immediately(EventCreatePlayer.new())
	
	print(as_text())
	is_done(self)
