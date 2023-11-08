extends RandomEvent
class_name RandomEventBats

func _init(_course_node:Node = null):
	super(_course_node)
	event_class = RandomEventBats
	
	base_chance = 0.001
	tags = ["BASE"]
	
	event_text = "Bats flock ominously."
	event_text_vars = []

static func try_event():
	return randf() < base_chance

func do_event():
	print(as_text())
	is_done(self)
