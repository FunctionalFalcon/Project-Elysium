class_name State_Rifle_shoot extends State




@onready var idle : State = $"../Idle"
@onready var run : State = $"../Run"
@onready var rifle_aim : State = $"../Rifle_aim"
var rifle:Node = null




func Enter() -> void:
	rifle = PlayerData.player_node.rifle_instance
	rifle.shoot_laser()
	#rifle.is_shot = true
	return 




func Exit() -> void:
	#await get_tree().create_timer(1).timeout
	#rifle.queue_free()
	"""
	Potential bug here. When deliberately spammed by player, can cause error as
	shoot instance in rifle_shoot is deleted by rifle_aim.
	"""
	return



func Process(_delta: float) -> State:
	if rifle.is_shot == false:
		return rifle_aim
	return



func Physics(_delta: float):
	return
