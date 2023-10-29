extends Control

func _ready():
	get_node("Timer").start(3)



func onTimerTimeout():
	get_node("SplashScreen").visible = false


func onStartBPressed():
	var loading_screen_s = preload("res://Source/LoadingScreen/LoadingScreen.tscn")
	var loading_screen = loading_screen_s.instantiate()
	add_child(loading_screen)
	var player_s = preload("res://Source/Player/Player.tscn")
	var starting_village_s = preload("res://Source/Scenes/StartingVillageS/StartingVillageS.tscn")
	var ui_s = preload("res://Source/UI/UI.tscn")
	var player = player_s.instantiate()
	get_node("/root/TAT").add_child(player)
	var starting_village = starting_village_s.instantiate()
	get_node("/root/TAT").add_child(starting_village)
	var ui = ui_s.instantiate()
	get_node("/root/TAT").add_child(ui)
	queue_free()

func onExitBPressed():
	get_tree().quit()
