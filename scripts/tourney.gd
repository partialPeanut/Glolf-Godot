extends Node
class_name Tourney

var league: League

@export var course_scene: PackedScene

@export var tourney_name: String
@export var sin_reward: int

var mods: Array

@export var all_players: Array
var remaining_players: Array
var killed_in_action = []
var round_winners = []
var winners: Array

@export var courses_per_round: Array
@export var sudden_death_at_round: int

var courses: Array
var round_num = -1

func init_new(_players: Array, _courses_per_round = [4, 1], _sudden_death = 1):
	league = get_node("/root/Main/%League")
	
	tourney_name = generate_tourney_name()
	sudden_death_at_round = _sudden_death
	sin_reward = randi_range(100000, 200000)
	
	mods = []
	
	all_players = _players.duplicate()
	remaining_players = _players.duplicate()
	
	courses_per_round = _courses_per_round

func generate_tourney_name():
	var title = Util.random_line_from_file("res://lists/t_titles.txt")
	var noun = Util.random_line_from_file("res://lists/t_nouns.txt")
	
	return title % noun
	
func initialize_courses(rn):
	var unpicked_players = remaining_players.duplicate()
	unpicked_players.shuffle()
	
	var num_courses = courses_per_round[rn]
	@warning_ignore("integer_division")
	var base_num_players = unpicked_players.size() / num_courses
	var bonus_players = unpicked_players.size() - num_courses * base_num_players
	
	courses.clear()
	for i in num_courses:
		var course = course_scene.instantiate()
		
		var mods = Mod.mods_of(self)
		for mod in mods:
			mod.on_course_create(null, course)
		
		courses.append(course)
		add_child(course)
		
		var num_players = base_num_players + (1 if i < bonus_players else 0)
		var course_players = unpicked_players.slice(0, num_players)
		unpicked_players = unpicked_players.filter(func(p): return !p in course_players)
		
		course.init_new(self, course_players)
		course.name = course.course_name

func in_sudden_death():
	return sudden_death_at_round != -1 && round_num >= sudden_death_at_round

func on_hole_complete():
	if courses.all(func(c): return c.end_of_hole):
		for c in courses:
			if c.hole_num < c.holes.size():
				get_node("/root/Main/%Onceler").queue_event(EventHoleStart.new(c))
			elif in_sudden_death() && c.get_winners().size() > 1:
				get_node("/root/Main/%Onceler").queue_event(EventHoleStart.new(c, true))
			else:
				get_node("/root/Main/%Onceler").queue_event(EventCourseFinish.new(c))

func on_course_complete():
	if courses.all(func(c): return c.end_of_course):
		if round_num < courses_per_round.size()-1:
			get_node("/root/Main/%Onceler").queue_event(EventRoundWinners.new())
		else:
			get_node("/root/Main/%Onceler").queue_event(EventTourneyFinish.new())

func get_course_of(p: Player):
	for c in courses:
		if p in c.all_players:
			return c

func get_info(p):
	return get_course_of(p).player_info[p]

func get_winners():
	var w = []
	for c in courses:
		w += c.get_winners()
	return w
