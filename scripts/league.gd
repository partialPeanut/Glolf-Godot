extends Node

@export var tourney_scene: PackedScene
@export var players_per_tourney = 48

var tourneys = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func new_tourney():
	var tourney = tourney_scene.instantiate()
	tourneys.append(tourney)
	add_child(tourney)
	
	tourney.init_new(choose_players_for_tourney())

func choose_players_for_tourney():
	return $Roster.random_players_for_tourney(players_per_tourney)
