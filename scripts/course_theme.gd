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

@export var random_event_tags: Array
@export var name_tags: Array

func generate_course_name():
	var adjective = Util.random_tagged_line_from_file("res://lists/c_adjectives.txt", name_tags)
	var noun = Util.random_tagged_line_from_file("res://lists/c_nouns.txt", name_tags)
	
	return "%s %s" % [adjective, noun]

func generate_hole():
	var hole = hole_scene.instantiate()
	return hole
