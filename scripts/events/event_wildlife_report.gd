extends LocalEvent
class_name EventWildlifeReport

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "Wildlife Report: %s"
	event_text_vars = ["Wasteland. Space empty of life."]

func do_event():
	queue_event(EventUpTop.new(course_node))
	
	print(as_text())
	is_done(self)
