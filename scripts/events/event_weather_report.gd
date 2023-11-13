extends LocalEvent
class_name EventWeatherReport

func _init(_course_node:Node = null):
	super(_course_node)
	event_text = "This course's weather predicts: %s"
	event_text_vars = ["Wasteland. Weather non-existent."]

func do_event():
	var mods = Mod.mods_of(course_node)
	for mod in mods:
		mod.on_weather_report(self)
	
	queue_event(EventHoleStart.new(course_node))
	display()
	is_done(self)
