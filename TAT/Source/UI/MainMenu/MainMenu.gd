extends Control

func _ready():
	get_node("timer").start(3)

func onTimerTimeout():
	get_node("splash_screen").visible = false

func onStartBPressed():
	var LoadingScreen = preload("res://Source/UI/LoadingScreen/LoadingScreen.tscn")
	var loading_screen = LoadingScreen.instantiate()
	loading_screen.set_name("loading_screen")
	add_child(loading_screen)
	loadingScene1()
	

func loadingScene1():
	var HUD = preload("res://Source/UI/HUD/HUD.tscn")
	var hud = HUD.instantiate()
	hud.set_name("hud")
	get_node("/root/TAT").add_child(hud)
	var Player = preload("res://Source/Characters/Players/Player.tscn")
	var player = Player.instantiate()
	player.set_name("player")
	get_node("/root/TAT").add_child(player)
	var Scene1 = preload("res://Source/World/Scene1/Scene1.tscn")
	var scene_1 = Scene1.instantiate()
	scene_1.set_name("scene_1") 
	get_node("/root/TAT").add_child(scene_1)
	queue_free()

func onExitBPressed():
	get_tree().quit()
