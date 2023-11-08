extends LocalEvent
class_name EventHoleFinish

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "That was Hole Number %d."
	event_text_vars = [-1]

func do_event():
	event_text_vars = [course_node.hole_num+1]
	course_node.finish_hole()
	
	print(as_text())
	is_done(self)
