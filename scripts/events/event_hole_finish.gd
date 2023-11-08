extends LocalEvent
class_name EventHoleFinish

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "That was Hole Number %d."
	event_text_vars = [-1]

func do_event():
	event_text_vars = [course_node.hole_num+1]
	course_node.finish_hole()
	
	var mods = Mod.mods_of(course_node)
	for mod in mods:
		mod.on_hole_finish(self)
	
	print(as_text())
	is_done(self)
