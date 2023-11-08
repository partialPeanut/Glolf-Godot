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

func all_random_events():
	return $"Random Events".get_children()

func try_tagged_events(tags:Array, course_node:Node):
	var always_in_pool = ["BASE"]
	var tag_pool = always_in_pool + tags
	
	var all_res = all_random_events()
	for re in all_res:
		if re.tags.any(func(t): return t in tag_pool) && re.try_event():
			queue_event_immediately(re.event_class.new(course_node))
