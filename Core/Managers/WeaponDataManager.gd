extends Node


var weapon_database: Dictionary = {}


var machete_filepath = "res://Core/Data/Weapon/machete.json"	
# weapon json file. Consider to rework here when more weapons are added.
# Also a rotation to weapons (or sec weps)


func _ready():
	load_weapon(machete_filepath)



func load_json_file(json_path):
	assert(FileAccess.file_exists(json_path), "Weapon JSON not found")
	
	var file := FileAccess.open(json_path, FileAccess.READ)
	assert(file != null, "Failed to open weapon file")
	
	var content := file.get_as_text()
	var parsed : Dictionary = JSON.parse_string(content)
	
	return parsed



func load_weapon(path: String) -> void:
	var data : Dictionary = load_json_file(path)
	var weapon_id : String = data["stats"]["id"]
	weapon_database[weapon_id] = data
	# load weapon files into dict
	# get weapon id
	# you have to do the static typing piece of shit instead of using :=
	# because load_json_file (explicitly, parse_string) returns Variant


func get_weapon_data(weapon_id: String) -> Dictionary:
	assert(weapon_database.has(weapon_id), "Weapon not found: " + weapon_id)
	return weapon_database[weapon_id]
