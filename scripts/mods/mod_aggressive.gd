extends Mod
class_name ModAggressive

func _init(_source:Node = null):
	super(_source)
	mod_class = ModAggressive
	tags = ["BASE", "STAT"]

func on_player_turn_result(e:GlobalEvent = null, _player:Player = null):
	if randf() < 1:
		onceler.queue_event_immediately(EventAggression.new(e.course_node, _player))
