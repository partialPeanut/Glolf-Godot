extends LocalEvent
class_name EventCourseStart

func _init(_course_node:Node):
	super(_course_node)
	event_text = "Division %s begins on %s!"
	event_text_vars = ["GRAY", "Green Greens"]

func do_event():
	event_text_vars = ["GRAY", course_node.course_name]
	
	queue_event(EventWeatherReport.new(course_node))
	print(as_text())
	is_done(self)
