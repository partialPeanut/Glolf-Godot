extends Node

var queued_events = []

func queue_event(e):
	queued_events.push_front(e)
	
func queue_event_immediately(e):
	queued_events.push_back(e)

func start_loop():
	$"Event Timer".start()

func trigger_next_event():
	if queued_events.is_empty():
		print("No events on stack!?")
		return false
	
	var e = queued_events.back()
	e.do_event()

func on_event_complete(e):
	queued_events.erase(e)
	$"Event Timer".start()
