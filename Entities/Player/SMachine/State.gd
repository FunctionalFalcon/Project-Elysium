class_name State extends Node


## STORES A REFERENCE TO THE PLAYER THAT THIS STATE BELONGS TO
static var player: Player
static var world: World
var weapon_inst : WeaponInst = null


func _ready():
	pass


func Enter() -> void:
	pass


func Exit() -> void:
	pass


func Process(_delta: float) -> State:
	return null


func Physics(_delta: float) -> State:
	return null

func HandleInput(_event: InputEvent) -> State:
	return null
