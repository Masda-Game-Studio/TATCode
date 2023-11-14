extends Node2D

func _ready():
	var MainMenu = preload("res://Source/UI/MainMenu/MainMenu.tscn")
	var main_menu = MainMenu.instantiate()
	main_menu.name = "main_menu"
	add_child(main_menu)
