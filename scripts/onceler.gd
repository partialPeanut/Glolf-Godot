extends Node
class_name Onceler

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
	
	var mods
	if e is LocalEvent: mods = Mod.mods_of(e.course_node)
	else: mods = Mod.mods_of(e.main_node.get_node("%League"))
	
	for mod in mods:
		mod.before_event(e)
	
	e.do_event()

func on_event_complete(e):
	queued_events.erase(e)
	$"Event Timer".start()

func all_random_events():
	return $"Random Events".get_children()

func try_tagged_events(tags:Array, course_node:Node, autism:float):
	var always_in_pool = ["BASE"]
	var tag_pool = always_in_pool + tags
	
	var all_res = all_random_events()
	for re in all_res:
		if re.tags.any(func(t): return t in tag_pool):
			var mods = Mod.mods_of(course_node)
			for mod in mods:
				mod.on_try_random_event(self, re)
				
			if re.try_event(autism):
				queue_event_immediately(re.event_class.new(course_node))
