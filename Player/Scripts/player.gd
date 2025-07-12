class_name Player extends CharacterBody2D




# MISC VAR BEGIN

var screen_size    #kích thước màn hình

@onready var state_machine : PlayerStateMachine = $StateMachine
@export var rifle_scene = preload("res://Player/Rangedweps/Rifle.tscn")
var rifle_instance: Node = null

# MISC VAR END




# MOVEMENT VAR BEGIN

var cardinal_dir : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

# MOVEMENT VAR END




# PLAYER VAR BEGIN

var player_health = 100.0   # player hp

# PLAYER VAR END




func _ready():
	state_machine.Initialize(self)
	screen_size = get_viewport_rect().size
	PlayerData.player_node = self
	rifle_inst()
	#refers to PlayerData.gd




func _process(_delta: float):
	player_movement()




func _physics_process(_delta: float):
	player_movement()
	move_and_slide()
	look_at(get_global_mouse_position())
	defense_trigger()




# MOVEMENT BEGIN




func player_movement():
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	pass




func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_dir
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	if direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_dir:
		return false
		
	cardinal_dir = new_dir
	
	return true




# MOVEMENT END




"""func Setstate() -> bool:
	return true
"""



# BLOCK/PARRY VARS


@onready var defense_scene = preload("res://Player/Defense/PlayerBlock.tscn")
var can_def = true


# BLOCK/PARRY BEGIN




func defense_trigger():
	if Input.is_action_just_pressed("block") and can_def == true:
		defense()




func defense():
	var playerPos = PlayerData.player_node.global_position
	
	var defense_instance = defense_scene.instantiate()
	defense_instance.global_position = playerPos
	get_parent().add_child(defense_instance)
	can_def = false
	await get_tree().create_timer(1.0).timeout
	can_def = true




func rifle_inst():
	rifle_instance = rifle_scene.instantiate()
	add_child(rifle_instance)
	#rifle_instance.visible = false
	print("rifle scene insted")
	return
"""
TODO:
"""
