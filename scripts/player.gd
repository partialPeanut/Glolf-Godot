extends Node

@export var id: int

@export var first_name: String
@export var last_name: String
@export var suffixes: PackedStringArray
@export var gender: String

@export var net_worth: int
@export var blahaj_owned: float
@export_enum("ALIVE", "DEAD") var mortality: String

@export var competence: float
@export var smartassery: float
@export var yeetness: float
@export var trigonometry: float
@export var topology: float
@export var bisexuality: float
@export var asexuality: float
@export var scrappiness: float
@export var charisma: float
@export var autism: float

func init_new(_id):
	id = _id
	
	var fn_file = FileAccess.open("res://lists/p_namesfirst.txt", FileAccess.READ)
	var fn_array = fn_file.get_as_text().split("\n")
	first_name = fn_array.pick_random()
	
	var ln_file = FileAccess.open("res://lists/p_nameslast.txt", FileAccess.READ)
	var ln_array = ln_file.get_as_text().split("\n")
	last_name = ln_array.pick_random()
	
	suffixes = []
	
	var g_file = FileAccess.open("res://lists/p_genders.txt", FileAccess.READ)
	var g_array = g_file.get_as_text().split("\n")
	gender = g_array.pick_random()
	
	var tax_bracket = randi() % 100
	net_worth = randi_range(-60000, 60000) if tax_bracket < 70 else randi_range(40000, 300000) if tax_bracket < 99 else randi_range(300000, 600000)
	blahaj_owned = randf_range(-20, 100) if randi() % 666 != 0 else 999999999999999999999999999999999999999999999
		
	mortality = "ALIVE" if randf() < 0.9 else "DEAD"
	
	competence = randfn(6,2)
	smartassery = randfn(6,2)
	yeetness = randfn(6,2)
	trigonometry = randfn(6,2)
	topology = randfn(6,2)
	bisexuality = randfn(6,2)
	asexuality = randfn(6,2)
	scrappiness = randfn(6,2)
	charisma = randfn(6,2)
	autism = randfn(6,2)
	
	$Ball.init_new()

func full_name():
	var _full_name = "%s %s" % [first_name, last_name]
	for suffix in suffixes:
		_full_name += " %s" % suffix
	return _full_name
