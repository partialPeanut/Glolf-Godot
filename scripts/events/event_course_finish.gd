extends LocalEvent
class_name EventCourseFinish

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "Division %s ends its course!"
	event_text_vars = ["GRAY"]

func do_event():
	course_node.finish_course()
	
	var mods = Mod.mods_of(course_node)
	for mod in mods:
		mod.on_course_finish(self)
	
	display()
	is_done(self)
