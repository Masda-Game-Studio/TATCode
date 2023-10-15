extends Node

var player_s = preload("res://Source/Player/Player.tscn")
var starting_village_s = preload("res://Source/Scenes/StartingVillageS/StartingVillageS.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_s.instantiate()
	add_child(player)
	var starting_village = starting_village_s.instantiate()
	add_child(starting_village)
