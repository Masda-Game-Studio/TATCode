extends Area2D

var is_body_inside = false
var body1

func handleSkills():
	if(is_body_inside):
		if(body1.name == "VillageBandit" || body1.name =="VillageBandit2"):
			if(get_node("/root/TAT/UI/Inventory/CharacterPage").slots["Slot1"] == "wooden_sword"):
				if (Input.is_action_just_pressed("FirstAbility")):
					print("FIRST ABILITY")
				elif (Input.is_action_just_pressed("SecondAbility")):
					print("SECOND ABILITY")
				elif (Input.is_action_just_pressed("ThirdAbility")):
					pass
				elif (Input.is_action_just_pressed("UltimateAbility")):
					print("ULTIMATE ABILITY")

func _input(event):
	handleSkills()

func onBodyShapeEntered(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	is_body_inside = true
	body1 = body

func onBodyShaeExited(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	is_body_inside = false
