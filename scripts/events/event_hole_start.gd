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
	
	event_text_vars = [course_node.hole_num+1]
	
	var mods = Mod.mods_of(course_node)
	for mod in mods:
		mod.on_hole_start(self)
	
	queue_event(EventUpTop.new(course_node))
	print(as_text())
	is_done(self)
