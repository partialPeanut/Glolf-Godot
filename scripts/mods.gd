extends Node
class_name Mod

static var league: League
static var onceler: Onceler

var mod_class = Mod
var tags = []

var source: Node

func _init(_source:Node = null):
	source = _source
	on_apply()

func _ready():
	if league == null: league = Main.get_node("%League")
	if onceler == null: onceler = Main.get_node("%Onceler")

static func mod_list():
	return league.get_node("Mods").get_children().map(func(c): return c.mod_class)

static func mods_of(x, exclude:Array = []) -> Array:
	var mods = []
	if x is Array:
		for n in x:
			mods += mods_of(n, exclude + mods)
	else:
		var exit = false
		var layer = x
		while !exit:
			mods += layer.mods.filter(func(m): return m not in exclude)
			
			if layer is Player:
				layer = league.tourney.get_course_of(layer)
			elif layer is Course:
				layer = layer.tourney
			elif layer is Tourney:
				layer = layer.league
			else:
				exit = true
	
	return mods

func on_apply(_e:GlobalEvent = null):
	pass

func on_remove(_e:GlobalEvent = null):
	pass

func before_event(_e:GlobalEvent = null):
	pass

func on_player_created(_e:GlobalEvent = null, _player:Player = null):
	pass

func on_tourney_created(_e:GlobalEvent = null, _tourney:Tourney = null):
	pass

func on_course_created(_e:GlobalEvent = null, _course:Course = null):
	pass

func on_hole_created(_e:GlobalEvent = null, _hole:Hole = null):
	pass

func on_tourney_start(_e:GlobalEvent = null):
	pass

func on_course_start(_e:GlobalEvent = null):
	pass

func on_weather_report(_e:GlobalEvent = null):
	pass

func on_hole_start(_e:GlobalEvent = null):
	pass

func on_up_top(_e:GlobalEvent = null):
	pass

func on_player_turn_start(_e:GlobalEvent = null, _player:Player = null):
	pass

func on_player_turn_result(_e:GlobalEvent = null, _player:Player = null):
	pass

func on_sink(_e:GlobalEvent = null, _player:Player = null):
	pass

func on_try_random_event(_e:GlobalEvent = null, _event:RandomEvent = null):
	pass

func on_hole_finish(_e:GlobalEvent = null):
	pass

func on_course_finish(_e:GlobalEvent = null):
	pass

func on_the_culling(_e:GlobalEvent = null):
	pass

func on_next_round(_e:GlobalEvent = null):
	pass

func on_tourney_finish(_e:GlobalEvent = null):
	pass
