extends Node

@export var player_scene: PackedScene

var all_players = []

func new_id():
	var id = randi()
	while all_players.any(func(p): return p.id == id):
		id = randi()
	return id

func create_new_player():
	var p = player_scene.instantiate()
	p.init_new(new_id())
	p.name = p.full_name()
	all_players.append(p)
	add_child(p)
	return p

func random_players_for_tourney(num):
	var unpicked_valid_players = all_players.filter(func(p): return p.mortality == "ALIVE")
	var picked_players = []
	
	if (num >= unpicked_valid_players.size()):
		return unpicked_valid_players
	
	for i in num:
		var p = unpicked_valid_players.pick_random()
		picked_players.append(p)
		unpicked_valid_players.erase(p)
	
	return picked_players
