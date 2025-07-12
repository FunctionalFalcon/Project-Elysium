class_name State_Melee extends State




# WEAPON VAR BEGIN


var attacking : bool = false
@onready var idle : State = $"../Idle"
@onready var run : State = $"../Run"


# WEAPON VAR END




# MELEE STATS
@export var attack_scene = preload("res://Player/Meleeweps/sword/sword_attack.tscn")
var attack_range = 50




# VAR FOR MAKING ATTACKS
#var playerPos: Vector2
#var mousePos: Vector2
#var direction: Vector2




## STORES A REFERENCE TO THE PLAYER THAT THIS STATE BELONGS TO
func Enter() -> void:
	attacking = true
	spawn_attack_hitbox(attack_scene,attack_range)
	print("slash.")
	attacking = false
	pass
	



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




# MELEE FUNCTION BEGIN


func HandleInput (_event: InputEvent)-> State:
	return null

"""
func EndAttack() -> void:
	attacking = false
"""


# MELEE FUNCTION END




# MELEE SPAWN HITBOX BEGIN


func spawn_attack_hitbox(scene,atk_range):
	var playerPos = player.global_position # start point
	var mousePos =  player.get_global_mouse_position()   # end point
	var direction = (mousePos - playerPos).normalized() #calculate direction vector
	var meleePos = playerPos + direction * atk_range # location where the hitbox should stay
	
	var attack_instance = scene.instantiate()
	player.get_parent().add_child(attack_instance)
	attack_instance.rotation = direction.angle()
	attack_instance.global_position = meleePos


# MELEE SPAWN HITBOX END
