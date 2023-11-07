extends LocalEvent
class_name EventPlayerTurn

func _init(_course_node:Node):
	super(_course_node)
	event_text = "%s takes a swing..."
	event_text_vars = ["Someone"]

func do_event():
	var current_player = course_node.players[course_node.player_num]
	course_node.player_info[current_player].strokes += 1
	
	event_text_vars = [current_player.full_name()]
	
	queue_event_immediately(EventPlayerTurnResult.new(course_node))
	print(as_text())
	is_done(self)
