extends Node
class_name Util

static func file_to_array_by_line(filename:String):
	var file = FileAccess.open(filename, FileAccess.READ)
	var array = Array(file.get_as_text().split("\n", false))
	for line in array:
		line.strip_escapes()
	return array

static func random_line_from_file(filename:String):
	return file_to_array_by_line(filename).pick_random()

static func random_tagged_line_from_file(filename:String, tags:Array = []):
	var always_in_pool = ["BASE"]
	var tag_pool = always_in_pool + tags
	
	var array = file_to_array_by_line(filename)
	array = array.filter(func(line): return tag_pool.any(func(tag): return tag in line))
	return array.pick_random().get_slice(":", 0)
	
static func curve_scrappy(base, curve, x):
	return pow(curve, pow(base, 6-x))
	
static func curve_loggy(bot, top, x):
	return (top-bot)/2 * (log((x-6+sqrt((x-6)*(x-6)+4))/2)/log(3+sqrt(10))+1) + bot
	
static func curve_expy(b, z, x):
	return z * pow(b, x*x/8000)
