class_name State_Rifle_aim extends State




@onready var idle : State = $"../Idle"
@onready var run : State = $"../Run"
@onready var rifle_shoot : State = $"../Rifle_shoot"

const move_speed = 300
var rifle: Node = null




func Enter() -> void:
	rifle = PlayerData.player_node.rifle_instance
	#rifle.visible = true
	rifle.aiming = true
	return 




func Exit() -> void:
	#rifle.queue_free()
	rifle.aiming = false
	rifle.line_aim.visible = false
	return 




func Process(_delta: float) -> State:
	rifle.aim_laser()
	player.velocity = player.direction * move_speed
	return




func Physics(_delta: float) -> State:
	if Input.is_action_just_pressed("gun"):
		rifle.aiming = true
	elif Input.is_action_just_pressed("attack") and rifle.is_shot == true:
		rifle.aiming = false
		return rifle_shoot
	elif Input.is_action_just_released("gun"):
		return run
	return



# AIM SHOOT FUNCTION BEGIN

"""

"""

# AIM SHOOT FUNCTION END
