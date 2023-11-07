extends Node

var course_theme: Node
var course_name: String

var players: Array
var player_info: Dictionary
var player_num = 0

var holes: Array
var hole_num = 0
var end_of_hole = false
var end_of_course = false

func init_new(_players, _num_holes = 9):
	course_theme = get_node("/root/Main/%Environment").get_random_course_theme()
	course_name = course_theme.generate_course_name()
	
	players = _players.duplicate()
	for p in players:
		player_info[p] = {
			"strokes": 0,
			"score": 0,
			"sunk": false
		}
	
	holes.clear()
	for i in _num_holes:
		var hole = course_theme.generate_hole()
		holes.append(hole)
		hole.name = "Hole Number %d" % (i+1)
		add_child(hole)

func start_hole():
	end_of_hole = false
	for pi in player_info.values():
		pi.strokes = 0
		pi.sunk = false
	holes[hole_num].activate()
	
func finish_hole():
	end_of_hole = true
	for pi in player_info.values():
		pi.score += pi.strokes
	hole_num += 1
	get_parent().on_hole_complete()

func finish_course():
	end_of_hole = false
	end_of_course = true
	get_parent().on_course_complete()

func find_unsunk_player_after(n):
	var next_players = players.slice(n+1).filter(func(p): return !player_info[p].sunk)
	if next_players.is_empty():
		return -1
	else:
		return players.find(next_players[0])
