extends Node

@export var tourney_scene: PackedScene
@export var players_per_tourney = 48

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func new_tourney():
	var tourney = tourney_scene.instantiate()
	tourney.set_players(choose_players_for_tourney())
	add_child(tourney)

func choose_players_for_tourney():
	return $Roster.random_players_for_tourney(players_per_tourney)
