extends GlobalEvent
class_name EventKillPlayer

var player: Player

func _init(_player:Player = null):
	player = _player
	event_text = "Death takes %s."
	event_text_vars = ["someone"]
	
func do_event():
	main_node.get_node("%League").kill_player(player)
	event_text_vars = [player.full_name()]
	
	var mods = Mod.mods_of(player)
	for mod in mods:
		mod.on_player_killed(self, player)
	
	display()
	is_done(self)
