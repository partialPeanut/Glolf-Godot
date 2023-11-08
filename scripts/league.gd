extends Node
class_name League

var tourney: Node
@export var tourney_scene: PackedScene
@export var players_per_tourney = 48

var mods = []
	
func new_tourney():
	var t = tourney_scene.instantiate()
	t.init_new(choose_players_for_tourney())
	
	var mods = Mod.mods_of(self)
	for mod in mods:
		mod.on_tourney_create(null, t)
	
	tourney = t
	add_child(t)
	return t

func choose_players_for_tourney():
	return $Roster.random_players_for_tourney(players_per_tourney)

func kill_players(_player):
	pass
