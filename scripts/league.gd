extends Node
class_name League

var tourney: Tourney
@export var tourney_scene: PackedScene
@export var players_per_tourney = 48

var mods = []
	
func new_tourney():
	var t = tourney_scene.instantiate()
	t.init_new(choose_players_for_tourney())
	t.league = self
	
	var _mods = Mod.mods_of(self)
	for _mod in _mods:
		_mod.on_tourney_create(null, t)
	
	tourney = t
	add_child(t)
	return t

func end_tourney():
	tourney = null

func choose_players_for_tourney():
	return $Roster.random_players_for_tourney(players_per_tourney)

func kill_player(p):
	p.mortality = "DEAD"
	if tourney != null:
		tourney.remove_player(p)
		tourney.killed_in_action.append(p)
