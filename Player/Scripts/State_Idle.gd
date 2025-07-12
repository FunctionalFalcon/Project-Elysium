class_name State_Idle extends State

@export var move_speed : float = 300.0
@onready var run : State = $"../Run"
@onready var melee : State = $"../Melee"
@onready var rifle_aim : State = $"../Rifle_aim"

func _ready():
	pass


func Enter() -> void:
	pass


func Exit() -> void:
	pass


func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		print("run.")
		return run
	player.velocity = Vector2.ZERO
	return null


func Physics(_delta: float) -> State:
	return null




func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return melee
		
	if Input.is_action_just_pressed("gun"):
		print("aimed")
		return rifle_aim
	"""
	elif Input.is_action_just_released("gun"):
		print("boom")
		return rifle
	"""

	return null
