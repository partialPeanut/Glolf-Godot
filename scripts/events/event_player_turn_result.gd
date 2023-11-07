extends LocalEvent
class_name EventPlayerTurnResult

func _init(_course_node:Node):
	super(_course_node)
	event_text = "No dice."
	event_text_vars = []

func do_event():
	var current_player = course_node.players[course_node.player_num]
	if randi() % 3 == 0:
		course_node.player_info[current_player].sunk = true
		event_text = "They nailed it!!"
	
	var next_player = course_node.find_unsunk_player_after(course_node.player_num)
	if course_node.find_unsunk_player_after(-1) == -1:
		queue_event(EventHoleFinish.new(course_node))
	elif next_player == -1:
		queue_event(EventUpTop.new(course_node))
	else:
		course_node.player_num = next_player
		queue_event(EventPlayerTurn.new(course_node))
	
	print(as_text())
	is_done(self)