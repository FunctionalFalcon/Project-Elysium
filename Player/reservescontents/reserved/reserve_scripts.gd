"""
extends CharacterBody2D


#MOVEMENT VAR

const SPEED = 400.0
var screen_size
const maxrange = 1000

#END MOVEMENT VAR




#GUN LASER VAR

var thickness = 6
var widthy = thickness
var aim = false
var laserdur = 0.5
@onready var collision = $Line2D/Hurtbox/CollisionShape2D
@onready var firerate = $"../Firerate"

var wait_time: float = 2.0  # Set the wait time
var time_passed: float = 0.0  # Initialize elapsed time
var run = false

#END LASER VAR



func _ready():
	screen_size = get_viewport_rect().size




func _physics_process(delta: float):
	
	
	
	
	#MOVEMENT BEGIN
	
	var direction_x = Input.get_axis("left", "right") * SPEED
	if direction_x == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = direction_x

	var direction_y = Input.get_axis("up", "down") * SPEED
	if direction_y == 0:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity.y = direction_y
	
	move_and_slide()
	look_at(get_global_mouse_position())
	
	#MOVEMENT END
	
	
	
	
	#LASER BEGIN
	
	$Line2D.width = widthy		#laser width
	var mouse_pos = get_local_mouse_position()	#var helps find mouse location
	var max_cast = mouse_pos.normalized() * maxrange
	$RayCast2D.target_position = max_cast
		#Explanation: since mouseposition is a vector, we can definitely
		#multiple it with maxrange to scale it up (so it technically doesnt hit
		#infinity, just an amount of range)
	
	
	if $RayCast2D.is_colliding():		#if collide object:
		$Line2D.set_point_position(1,$Line2D.to_local(max_cast))		#set point1 to the collide position
	else:
		$Line2D.points[1] = max_cast		#set point1 to max range (beam travels to max range)
	
	
	if aim:		#check shoot condition: true
		collision.shape.b = $Line2D.points[1]		#set point B of SegmentShape2D(CollisionShape2D) to point 1 (destination) of line2D => Vector
		$Line2D.visible = true		#make laser shot visible
		$Line2D.default_color.a = 0.6
	else:
		collision.shape.b = Vector2.ZERO
			#Vector (0,0), understand as "no collision vector"
		collision.disabled = true		#disable collision
		$Line2D.visible = false		#make laser shot invisible


	if Input.is_action_just_pressed("shoot"):
		aim = true
	elif Input.is_action_just_released("shoot"):
		run = true
		aim = false
	if run:
		
		time_passed += delta  # Increment elapsed time
		print(time_passed)
		if time_passed >= wait_time:
			_on_timeout()  # Call the timeout function
			time_passed = 0.0  # Reset the timer



#LASER END



func _on_timeout():		#delay laser disable
	collision.disabled = false		#enable collision
	$Line2D.default_color.a = 1
	run = false
	print("Manual timer finished!")

"""




"""

extends Node

var wait_time: float = 1.0  # Set the wait time
var time_passed: float = 0.0  # Initialize elapsed time

func _process(delta: float):
	time_passed += delta  # Increment elapsed time
	if time_passed >= wait_time:
		_on_timeout()  # Call the timeout function
		time_passed = 0.0  # Reset the timer

func _on_timeout():
	# Logic to be executed after the wait time
	print("Manual timer finished!")
	queue_free()  # Optionally remove this node from the scene


"""


#Laser beam code


"""
extends Node2D


#GUN LASER VAR

const maxrange = 2000				#chiều dài max của laser
var thickness = 6				#độ dày laser
var widthy = thickness
var laserdur = 0.1					#thời gian laser bắn tồn tại

@onready var collision = $Line2D/Hurtbox/CollisionShape2D				#laser collision
@onready var firerate = $Firerate					#cooldown của laser

var wait_time_a: float = 0.2  #thời gian chờ
var time_passed_a: float = 0.0
var aim = false					#biến ngắm
var shoot = false					#biến bắn


#LASER BEGIN

func _physics_process(delta: float):
	$Line2D.width = widthy		#laser width
	var mouse_pos = get_local_mouse_position()	#var helps find mouse location
	var max_cast = mouse_pos.normalized() * maxrange
	$RayCast2D.target_position = max_cast
		#Explanation: since mouseposition is a vector, we can definitely
		#multiple it with maxrange to scale it up (so it technically doesnt hit
		#infinity, just an amount of range)
	
	
	if $RayCast2D.is_colliding():		#if collide object:
		$Line2D.set_point_position(1,$Line2D.to_local(max_cast))		#set point1 to the collide position
	else:
		$Line2D.points[1] = max_cast		#set point1 to max range (beam travels to max range)


	if Input.is_action_just_pressed("aim"):
		aim = true
	elif Input.is_action_just_released("aim"):
		aim = false
		shoot = true
		
		
	if aim:
		collision.shape.b = $Line2D.points[1]		#set point B of SegmentShape2D(CollisionShape2D) to point 1 (destination) of line2D => Vector
		$Line2D.visible = true		#make laser shot visible
		$Line2D.default_color = Color(255,0,0,0.6)
	else:
		collision.shape.b = Vector2.ZERO
			#Vector (0,0), understand as "no collision vector"
		
		
	if shoot:
		time_passed_a += delta  # Increment elapsed time
		print(time_passed_a)
		$Line2D.default_color = Color(255,173,0,1)
		collision.disabled = false
		
		if time_passed_a >= wait_time_a:
			_on_shoot_timeout()  # Call the timeout function
			collision.disabled = true
			$Line2D.visible = false		#make laser shot invisible
			time_passed_a = 0.0  # Reset the timer



func _on_shoot_timeout():		#delay laser disable
	shoot = false
	print("Manual timer finished!")
	
"""



"""extends Node2D

const maxrange = 5000

var thickness = 8
var widthy = thickness
var shoot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Line2D.width = widthy	#laser width
	
	var mouse_pos = get_local_mouse_position()	#var helps find mouse location
	var max_cast = mouse_pos.normalized() * maxrange
	$RayCast2D.target_position = max_cast
	Explanation: since mouseposition is a vector, we can definitely
	multiple it with maxrange to scale it up (so it technically doesnt hit
	infinity, just an amount of range)

	
	if $RayCast2D.is_colliding():
		$reference.global_position = $RayCast2D.get_collision_point()
		$Line2D.set_point_position(1,$Line2D.to_local($reference.global_position))
	else:
		$reference.global_position = $RayCast2D.target_position
		$Line2D.points[1] = $reference.global_position
	"""
