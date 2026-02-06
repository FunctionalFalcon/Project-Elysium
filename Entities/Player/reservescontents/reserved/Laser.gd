extends Node2D


#GUN LASER VAR

const maxrange = 2000				#chiều dài max của laser
var thickness = 6				#độ dày laser
var widthy = thickness
var laserdur = 0.1					#thời gian laser bắn tồn tại

@onready var collision = $Line2D/Hurtbox/CollisionShape2D				#laser collision
@onready var firerate = $Firerate					#cooldown của laser
@onready var player = get_parent()

var wait_time_a: float = 0.2  #thời gian chờ
var time_passed_a: float = 0.0
var aim = false					#biến ngắm
var shoot = false					#biến bắn

#LASER BEGIN

func _physics_process(delta: float):
	
	$Line2D.points[0] = player.global_position
	
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
	
#LASER END


"""
TODO:
	- gun should have static shoot point and end point
	(The shit must not move while player is moving, afterimage)
	- aim and inaccuracy system
"""
