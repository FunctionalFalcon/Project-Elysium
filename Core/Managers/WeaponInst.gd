class_name WeaponInst
extends Node

#var weapon_data_manager = preload("res://Core/Managers/WeaponDataManager.gd").new()



# --- base stats ---
var w_id: String
var w_name: String
var atk_range: int
var dash_rec: float

# posture
var posture_max: int
var posture_recovery: int
var posture_regen: int

# parry
var parry_window: float
var parry_recovery: float

# execution
var exec_duration: float
var exec_type: String

# skills
var skills: Dictionary


# yeah i asked the clanker to type the part above for me
# i dont want to waste time swapping long ass json codes


func wep_cache_init(weapon_id: String):
	var weapon_data: Dictionary = WeaponDataManager.get_weapon_data(weapon_id)
	
	assert(weapon_data.has("stats"), "Weapon has no stats")
	assert(weapon_data.has("skills"), "Weapon has no skills")

	var stats : Dictionary = weapon_data["stats"]

	# --- basic ---
	w_id = stats["id"]
	w_name = stats["name"]
	atk_range = stats["atk_range"]
	dash_rec = stats["dash_rec"]

	# --- posture ---
	posture_max = stats["posture"]["max"]
	posture_recovery = stats["posture"]["recovery"]
	posture_regen = stats["posture"]["regen"]

	# --- parry ---
	parry_window = stats["parry"]["window"]
	parry_recovery = stats["parry"]["recovery"]

	# --- execution ---
	exec_duration = stats["execution"]["duration"]
	exec_type = stats["execution"]["type"]

	# --- skills ---
	skills = weapon_data["skills"]
