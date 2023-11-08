extends Node
class_name Player

@export var id: int

@export var first_name: String
@export var last_name: String
@export var suffixes: PackedStringArray
@export var gender: String

@export var mods: Array

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
	
	first_name = Util.random_line_from_file("res://lists/p_namesfirst.txt")
	last_name = Util.random_line_from_file("res://lists/p_nameslast.txt")
	suffixes = []
	gender = Util.random_line_from_file("res://lists/p_genders.txt")
	mortality = "ALIVE" if randi() % 100 != 0 else "DEAD"
	
	mods = []
	if randf() < 0.3:
		mods.append(ModAggressive.new(self))
	
	var tax_bracket = randi() % 100
	net_worth = randi_range(-60000, 60000) if tax_bracket < 70 else (randi_range(40000, 300000) if tax_bracket < 99 else randi_range(300000, 600000))
	blahaj_owned = randf_range(-20, 100) if randi() % 666 != 0 else 999999999.999999999
	
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
	if !suffixes.is_empty():
		_full_name += " " + " ".join(suffixes)
	return _full_name

func stat_readout():
	var space_amt = 9
	var stats = "Name: %*s"           % [ space_amt + 8, full_name() ]
	stats +=  "\nGender: %*s"         % [ space_amt + 6, gender ]
	stats +=  "\nMortality: %*s"      % [ space_amt + 3, mortality ]
	stats +=  "\n"
	stats +=  "\nNet Worth: %*d"      % [ space_amt + 3, net_worth ]
	stats +=  "\nBlahaj Owned: %*f"   % [ space_amt + 0, blahaj_owned ]
	stats +=  "\n"
	stats +=  "\nCompetence: %*.1f"   % [ space_amt + 2, competence ]
	stats +=  "\nSmartassery: %*.1f"  % [ space_amt + 1, smartassery ]
	stats +=  "\nYeetness: %*.1f"     % [ space_amt + 4, yeetness ]
	stats +=  "\nTrigonometry: %*.1f" % [ space_amt + 0, trigonometry ]
	stats +=  "\nTopology: %*.1f"     % [ space_amt + 4, topology ]
	stats +=  "\nBisexuality: %*.1f"  % [ space_amt + 1, bisexuality ]
	stats +=  "\nAsexuality: %*.1f"   % [ space_amt + 2, asexuality ]
	stats +=  "\nScrappiness: %*.1f"  % [ space_amt + 1, scrappiness ]
	stats +=  "\nCharisma: %*.1f"     % [ space_amt + 4, charisma ]
	stats +=  "\nAutism: %*.1f"       % [ space_amt + 6, autism ]
	return stats
