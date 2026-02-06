class_name State_Melee extends State




# WEAPON VAR BEGIN


var attacking : bool = false
@onready var idle : State = $"../Idle"
@onready var run : State = $"../Run"


# WEAPON VAR END


# MELEE STATS
# MELEE SCENES
@export var attack_scene = load("res://Weapons/Meleeweps/Melee weapon/Attack.tscn")


# VAR FOR MAKING ATTACKS
#var playerPos: Vector2
#var mousePos: Vector2
#var direction: Vector2




## STORES A REFERENCE TO THE PLAYER THAT THIS STATE BELONGS TO

func _ready():
	pass


func Enter() -> void:
	call_slash()




func Exit() -> void:
	pass




func Process(_delta: float) -> State:
	player.velocity = Vector2.ZERO 
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return run
	return null




func Physics(_delta: float) -> State:
	return null



"""
main functions below
"""

# MELEE INPUT


func HandleInput (_event: InputEvent)-> State:
	return null


# MELEE





# MELEE SPAWN HITBOX


func call_slash():
	attacking = true
	spawn_attack_hitbox(attack_scene, weapon_inst.atk_range)
	print("slash.")
	attacking = false


func spawn_attack_hitbox(atk_scene, atk_range):
	var playerPos = player.global_position # start point
	var mousePos =  player.get_global_mouse_position()   # end point
	var direction = (mousePos - playerPos).normalized() #calculate direction vector
	var meleePos = playerPos + direction * atk_range # location where the hitbox should stay
	
	var attack_instance = atk_scene.instantiate()
	player.get_parent().add_child(attack_instance)
	attack_instance.rotation = direction.angle()
	attack_instance.global_position = meleePos

	#print(attack)
