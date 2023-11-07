extends Node

@export var course_scene: PackedScene

@export var num_rounds = 3
@export var course_mult_per_round = 2

var tourney_name: String
var all_players: Array
var remaining_players: Array
var courses: Array
var round_num = 0

func init_new(_players: Array, _num_rounds = 3, _course_mult_per_round = 2):
	tourney_name = generate_tourney_name()
	all_players = _players.duplicate()
	remaining_players = _players.duplicate()
	
	num_rounds = _num_rounds
	course_mult_per_round = _course_mult_per_round
	
	initialize_courses(0)

func generate_tourney_name():
	var tt_file = FileAccess.open("res://lists/t_titles.txt", FileAccess.READ)
	var tt_array = Array(tt_file.get_as_text().split("\n"))
	var title = tt_array.pick_random()
	
	var tn_file = FileAccess.open("res://lists/t_nouns.txt", FileAccess.READ)
	var tn_array = Array(tn_file.get_as_text().split("\n"))
	var noun = tn_array.pick_random()
	
	return title % noun
	
func initialize_courses(rn):
	var unpicked_players = remaining_players.duplicate()
	unpicked_players.shuffle()
	
	var num_courses = roundi(pow(course_mult_per_round, num_rounds - rn - 1))
	@warning_ignore("integer_division")
	var base_num_players = unpicked_players.size() / num_courses
	var bonus_players = unpicked_players.size() - num_courses * base_num_players
	
	courses.clear()
	for i in num_courses:
		var course = course_scene.instantiate()
		courses.append(course)
		add_child(course)
		
		var num_players = base_num_players + 1 if i < bonus_players else 0
		var course_players = unpicked_players.slice(0, num_players)
		unpicked_players = unpicked_players.filter(func(p): return !p in course_players)
		
		course.init_new(course_players)
		course.name = course.course_name
