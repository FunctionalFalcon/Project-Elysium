extends Node2D




var dur = 1
#var playerPos = PlayerData.player_node.global_position




# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(dur).timeout
	queue_free()
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass




func _on_block_hitbox_area_entered(area: Node2D):  #detect enemy attacks entering the area2d
	print("Detected Area: ", area.name)

	if area.is_in_group("Attack"):
		print("Detected Attack")
	else:
		print("Detected Else.")
