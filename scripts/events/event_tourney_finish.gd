extends GlobalEvent
class_name EventTourneyFinish

func _init():
	event_text = "The tournament is over!! Congratulations to the winner: %s"
	event_text_vars = ["No one"]

func do_event():
	print(as_text())
	is_done(self)
