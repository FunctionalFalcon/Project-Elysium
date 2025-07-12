extends Node2D




var dur = 1




# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(dur).timeout
	queue_free()
	pass




# DETECT ENEMY BEGIN


func _on_sword_attack_area_entered(area: Area2D):
	print("Detected Area: ", area.name)

	if area.is_in_group("Enemy_Hitbox"):
		print("Hit enemy!")
	else:
		print("Hit something else.")


# DETECT ENEMY END
