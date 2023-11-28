extends Mod
class_name ModDrowning

var turns_until_death: int

func _init(_source:Node = null, _turns_until_death = 4):
	super(_source)
	turns_until_death = _turns_until_death
	mod_class = ModDrowning
	tags = ["TEMP_EFFECT"]

func on_apply(_e = null):
	if !source is Player:
		ModDrowning.remove(self)
		return
	
	if _e != null:
		_e.event_text += " %s is drowning and has %d turns to sink or swim!"
		_e.event_text_vars += [source.full_name(), turns_until_death]
	source.competence -= 4
	source.yeetness -= 1.5
	source.trigonometry -= 1.5
	source.topology -= 1.5

func on_remove(_e = null):
	if source == null:
		return
	
	if _e != null:
		_e.event_text += " %s sinks and breathes freely!"
		_e.event_text_vars += [source.full_name()]
	source.competence += 4
	source.yeetness += 1.5
	source.trigonometry += 1.5
	source.topology += 1.5

func on_sink(_e = null, _p:Player = null):
	if _p == source:
		ModDrowning.remove(self, _e)

func on_player_turn_result(_e = null, _p = null):
	trigger_drown_tick(_e, _p)

func trigger_drown_tick(_e, _p):
	if turns_until_death > 0:
		if _e != null:
			_e.event_text += " %d strokes until %s drowns."
			_e.event_text_vars += [turns_until_death, _p.full_name()]
		turns_until_death -= 1
	else:
		if _e != null:
			_e.event_text += " %s swims and cannot breathe."
			_e.event_text_vars += [_p.full_name()]
		onceler.queue_event_immediately(EventKillPlayer.new(_p))
