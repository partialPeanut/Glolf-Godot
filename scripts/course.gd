extends Node
class_name Course

var tourney: Tourney

@export var course_theme: Node
@export var course_name: String
@export var random_event_tags: Array

@export var mods: Array

@export var all_players: Array
@export var active_players: Array
@export var player_num = 0
@export var player_info: Dictionary

@export var holes: Array
@export var hole_num = 0

var end_of_hole = false
var end_of_course = false
var sudden_death = false

func init_new(_tourney, _all_players, _num_holes = 9):
	tourney = _tourney
	
	course_theme = get_node("/root/Main/%Environment").get_random_course_theme()
	course_name = course_theme.generate_course_name()
	random_event_tags = course_theme.random_event_tags
	
	mods = []
	
	all_players = _all_players.duplicate()
	player_info.clear()
	for p in all_players:
		player_info[p] = {
			"strokes": 0,
			"score": 0,
			"sunk": false
		}
	
	holes.clear()
	for i in _num_holes:
		append_new_hole()

func append_new_hole():
	var hole = course_theme.generate_hole()
	hole.name = "Hole Number %d" % holes.size()
	hole.course = self
	
	var _mods = Mod.mods_of(self)
	for _mod in _mods:
		_mod.on_hole_create(null, hole)
	
	holes.append(hole)
	add_child(hole)

func start_course():
	pass

func start_hole(_sudden_death:bool = false):
	end_of_hole = false
	sudden_death = _sudden_death
	
	if sudden_death:
		active_players = get_winners()
		append_new_hole()
	else:
		active_players = all_players.duplicate()
	
	for p in active_players:
		player_info[p].strokes = 0
		player_info[p].sunk = false
	holes[hole_num].activate()

func try_random_events(autism:float):
	get_node("/root/Main/%Onceler").try_tagged_events(random_event_tags, self, autism)

func finish_hole():
	end_of_hole = true
	for p in active_players:
		player_info[p].score += player_info[p].strokes
	# if sudden_death:
		# var failures = active_players.filter(func(p): return !p in get_winners())
		# get_node("/root/Main/%League").kill_players(failures)
	# Make sudden death lethal.
	hole_num += 1
	get_parent().on_hole_complete()

func finish_course():
	end_of_hole = false
	end_of_course = true
	get_parent().on_course_complete()

func get_current_player():
	return active_players[player_num]

func get_winners(exclude:Array = []):
	var eligible_players = active_players.filter(func(p): return !p in exclude)
	var best_score = eligible_players.reduce(
		func find_min_score(best, p):
			var this_score = player_info[p].score
			return this_score if best == 0.0000001 || this_score < best else best
	, 0.0000001)
	return eligible_players.filter(func(p): return player_info[p].score == best_score)

func all_unsunk_players():
	return active_players.filter(func(p): return !player_info[p].sunk)

func find_unsunk_player_after(n):
	var unsunk_players = all_unsunk_players()
	var next_players = active_players.slice(n+1).filter(func(p): return p in unsunk_players)
	if next_players.is_empty():
		return -1
	else:
		return active_players.find(next_players[0])
