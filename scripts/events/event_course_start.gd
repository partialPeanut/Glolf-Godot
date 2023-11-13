extends LocalEvent
class_name EventCourseStart

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "Division %s begins on %s!"
	event_text_vars = ["GRAY", "Green Greens"]

func do_event():
	course_node.start_course()
	
	event_text_vars = ["GRAY", course_node.course_name]
	
	var mods = Mod.mods_of(course_node)
	for mod in mods:
		mod.on_course_start(self)
	
	queue_event(EventWeatherReport.new(course_node))
	display()
	is_done(self)
