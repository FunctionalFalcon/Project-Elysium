"""
extends Node


signal game_ready		# signal to spawn players
signal folder_ready(folder)		# signal folder is ready
signal path_ready(path, resource)		# signal file is ready


var loaded_rsc := {}		# dict of loaded rscs
var load_order = [			# list of shits to load
	"res://Core",
	"res://Assets/Sprite/",
	"res://Entities/Player/",
	"res://Weapons/",
	"res://Entities/Enemy/",
	"res://World/"
]


func _ready():
	_load_all()




func _load_all():
	for folder in load_order:
		_load_folder(folder)
		emit_signal("folder_ready", folder)
	emit_signal("game_ready")
	print("lets cook")
	pass
# when all folders




func _load_folder(path: String):
	var dir = DirAccess.open(path)		# open folder with dir
	if dir == null:
		push_warning("Folder is cooked: " + path)
		return		# if no dir then folder path is cooked
	
	dir.list_dir_begin()   # get files
	var fileName = dir.get_next()
	var files := []
	while fileName != "":		# while file name is not empty
		if dir.current_is_dir():
			_load_folder(path + "/" + fileName)		# if folder inside folder then recursive
		else:
			files.append(fileName)	# if file then append
			
			
		fileName = dir.get_next()
	dir.list_dir_end()
	
	
	files.sort()
	
	
	for f in files:
		var fullPath = path + "/" + f
		var res = load(fullPath)
		if res:
			loaded_rsc[fullPath] = res
			emit_signal("path_ready", fullPath, res)
			print("Loaded: ", fullPath)  
		
		# give full path to files in dict
"""
