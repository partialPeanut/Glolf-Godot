extends Node

@export var hole_scene: PackedScene

@export var roughness = 100
@export var heterosexuality = 100
@export var thicc = 100
@export var verdancy = 100
@export var obedience = 100
@export var chaos = 100
@export var quench = 100
@export var thirst = 100

@export var random_encounter_tags: Array
@export var name_tags: Array

func generate_course_name():
	var ca_file = FileAccess.open("res://lists/c_adjectives.txt", FileAccess.READ)
	var ca_array = Array(ca_file.get_as_text().split("\n"))
	ca_array = ca_array.filter(func(line): return "BASE" in line || name_tags.any(func(tag): return tag in line))
	var adjective = ca_array.pick_random().get_slice(":", 0)
	
	var cn_file = FileAccess.open("res://lists/c_nouns.txt", FileAccess.READ)
	var cn_array = Array(cn_file.get_as_text().split("\n"))
	cn_array = cn_array.filter(func(line): return "BASE" in line || name_tags.any(func(tag): return tag in line))
	var noun = cn_array.pick_random().get_slice(":", 0)
	
	return "%s %s" % [adjective, noun]

func generate_hole():
	var hole = hole_scene.instantiate()
	return hole
