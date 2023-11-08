extends LocalEvent
class_name RandomEvent

static var event_class
static var base_chance: float
static var tags: Array

func _init(_course_node:Node = null):
	super(_course_node)
	event_class = RandomEvent
	base_chance = -1
	tags = ["BASE"]

static func try_event():
	return randf() < base_chance