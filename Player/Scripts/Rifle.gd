extends Node2D




# GUN STATS
const maxrange = 1000
const thickness = 4
const laserdur = 0.5
const damage = 6
var aiming = false
var is_shot = true
var from
var to


# ONREADY NODES
@onready var line_aim = $Line2D_aim
@onready var timer = $Firerate
@onready var line_shoot = $Line2D_shoot
#@onready var collision = $Line2D/Area2D/CollisionShape2D




# VAR FOR LASER DRAWING
var hitPos: Vector2 # var is used to store hit location
var laser_tween: Tween = null
var playerPos: Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float):
	return



# VAR FOR SHOOT LASER BEAM

func shoot_beam():
	var laser = Line2D.new()

	laser.width = thickness
	laser.default_color = Color(235,130,0,1)
	laser.points = [playerPos,hitPos]
	laser.z_index = 5
	get_tree().get_root().add_child(laser)
	
	#tween
	if laser_tween and laser_tween.is_valid():   #kill surplus tweens to avoid overflowing/too much unused tween
		laser_tween.kill()
	else:
		laser_tween = get_tree().create_tween()    #create new tween
	laser_tween.tween_property(laser,"modulate:a",0,laserdur)
	laser_tween.tween_callback(Callable(laser, "hide"))      # hide the line_shoot to avoid exist meaningless



# LASER DRAWING BEGIN



func aim_laser():
	if aiming:
		setup_line(line_aim,PlayerData.player_node.global_position,get_global_mouse_position(),thickness,0.25)
	#else:
		#line_aim.visible = false
		#rpidly getting called to redraw aim laser (in real time delta)


"""
Note: temporarily ignore this function.
Combining tween and shoot laser into shoot_beam()
watch timer.start() to for the sniper cooldown
"""
func shoot_laser():
	setup_raycast()
	shoot_beam()
	is_shot = false
	timer.start()



# LASER DRAWING END



#LASER SETUP BEGIN

func setup_line(line: Line2D, from: Vector2, to: Vector2, width:float, alpha: float):
	line.width = width
	line.points = [line.to_local(from),line.to_local(to)]
	line.modulate.a = alpha
	line.visible = true

#LASER SETUP END



# RAYCAST BEGIN

func setup_raycast():
	playerPos = PlayerData.player_node.global_position
	var mousePos = get_global_mouse_position()
	var direction = (mousePos - playerPos).normalized() #calculate direction vector
	hitPos = playerPos + direction * maxrange
	
	
	var ray_params = PhysicsRayQueryParameters2D.create(playerPos, hitPos)
	ray_params.exclude = [self]
	ray_params.collide_with_areas = true
	ray_params.collide_with_bodies = false
	ray_params.collision_mask = 4    #because godot use bitmap instead of just collision
	
	var rc_result = get_world_2d().direct_space_state.intersect_ray(ray_params)    #return the object intersected the ray
	if rc_result:
		hitPos = rc_result.position    # get position at intersect place
		var collider = rc_result.collider    # returns the first object that the ray intersects
		if collider and collider.is_in_group("Enemy_Hitbox"):   # enemy detected
			print("Hit a mf: ", collider)
		return 
	print("hit nothing lmao") # missed
	return

#RAYCAST END



func _on_firerate_timeout():
	is_shot = true
