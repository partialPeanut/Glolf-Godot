extends Node

@export var course_scene: PackedScene
@export var course_amt_array: Array

var tourney_name: String
var all_players: Array
var remaining_players: Array
var courses: Array
var round_num = 0

func init_new(_players: Array, _course_amt_array = [4, 1]):
	tourney_name = generate_tourney_name()
	all_players = _players.duplicate()
	remaining_players = _players.duplicate()
	
	course_amt_array = _course_amt_array

func generate_tourney_name():
	var title = Util.random_line_from_file("res://lists/t_titles.txt")
	var noun = Util.random_line_from_file("res://lists/t_nouns.txt")
	
	return title % noun
	
func initialize_courses(rn):
	var unpicked_players = remaining_players.duplicate()
	unpicked_players.shuffle()
	
	var num_courses = course_amt_array[rn]
	@warning_ignore("integer_division")
	var base_num_players = unpicked_players.size() / num_courses
	var bonus_players = unpicked_players.size() - num_courses * base_num_players
	
	courses.clear()
	for i in num_courses:
		var course = course_scene.instantiate()
		courses.append(course)
		add_child(course)
		
		var num_players = base_num_players + (1 if i < bonus_players else 0)
		var course_players = unpicked_players.slice(0, num_players)
		unpicked_players = unpicked_players.filter(func(p): return !p in course_players)
		
		course.init_new(course_players)
		course.name = course.course_name

func on_hole_complete():
	if courses.all(func(c): return c.end_of_hole):
			for c in courses:
				if c.hole_num < c.holes.size():
					get_node("/root/Main/%Onceler").queue_event(EventHoleStart.new(c))
				else:
					get_node("/root/Main/%Onceler").queue_event(EventCourseFinish.new(c))

func on_course_complete():
	if courses.all(func(c): return c.end_of_course):
		round_num += 1
		if round_num < course_amt_array.size():
			get_node("/root/Main/%Onceler").queue_event(EventNextRound.new())
		else:
			get_node("/root/Main/%Onceler").queue_event(EventTourneyFinish.new())
