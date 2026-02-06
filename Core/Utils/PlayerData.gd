extends Node
var player_node: Node = null



"""
func get_stat(stat_name: String):
	
	

	if player_node and player_node.stats.has(stat_name):
		return player_node.stats[stat_name]
		
	if not player_node:
		await self.player_ready
		return get_stat(stat_name)
"""




"""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

"""

"""
Why not load player.gd directly?
Because its attached to a scene
When autoloadded, godot tries to create
a fresh player scene
all went shit
dont do that, thats retarded

This one is just pure logic
Can control everything
also cleaner than kotex
"""
