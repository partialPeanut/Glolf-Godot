extends LocalEvent
class_name EventCourseFinish

func _init(_course_node:Node):
	super(_course_node)
	event_text = "Division %s ends its course!"
	event_text_vars = ["GRAY"]

func do_event():
	course_node.finish_course()
	print(as_text())
	is_done(self)
