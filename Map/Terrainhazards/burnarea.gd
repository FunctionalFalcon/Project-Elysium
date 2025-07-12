extends Node2D




# BURN STATS
var burning = false
var loops := []
#var loops := {} #using dictionary



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass
	



# DAMAGE BEGIN


func _on_damage_area_area_entered(area: Node2D):
	var id = area.get_parent().get_instance_id()
	
	if not loops.has(id):
		loops.append(id)
	
	while loops.has(id):
		print("Detected Area: ", area.name)
		print(area.global_position)
		await get_tree().create_timer(0.5).timeout


func _on_damage_area_area_exited(area: Node2D):
	var id = area.get_parent().get_instance_id()
	loops.erase(id)
	
	
# DAMAGE END





"""
# functional detection of players and (maybe) enemies
# need to make it detect every 0.5s

# backup code
func _on_damage_area_body_entered(body: Node2D):
	var id = body.get_instance_id()
	var iteration = 0
	
	if not loops.has(id):
		loops[id] = 0
	loops[id] += 1
	
	iteration = loops[id]
	while loops.has(id) and loops[id] == iteration:
		print("Detected Area: ", body.name)
		print(body.global_position)
		print(loops)
		await get_tree().create_timer(0.5).timeout
		
# This function by abusing dictionary.
# get entities ids
# slap all ids into a dictionary
# +1 for the value
# after +1 (iteration and value equal), create separate timer
# I decided to use list because its much lighter
"""
