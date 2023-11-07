extends Node

func get_random_course_theme():
	return get_children().pick_random()
