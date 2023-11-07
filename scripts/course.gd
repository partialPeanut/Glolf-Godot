extends Node

var course_theme: Node
var course_name: String
var players: Array
var holes: Array
var current_hole: Node
var hole_num = -1

func init_new(_players, _num_holes = 9):
	course_theme = get_node("/root/Main/%Environment").get_random_course_theme()
	course_name = course_theme.generate_course_name()
	
	players = _players
	holes.clear()
	for i in _num_holes:
		var hole = course_theme.generate_hole()
		holes.append(hole)
		hole.name = "Hole Number %d" % (i+1)
		add_child(hole)

func start_next_hole():
	hole_num += 1
	current_hole = holes[hole_num]
	current_hole.activate()
