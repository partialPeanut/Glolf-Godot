extends LocalEvent
class_name EventHoleStart

var sudden_death: bool

func _init(_course_node:Node = null, _sudden_death:bool = false):
	super(_course_node)
	sudden_death = _sudden_death
	event_text = "Next up: Hole Number %d."
	event_text_vars = [-1]

func do_event():
	course_node.start_hole(sudden_death)
	
	queue_event(EventWildlifeReport.new(course_node))
	event_text_vars = [course_node.hole_num+1]
	print(as_text())
	is_done(self)
