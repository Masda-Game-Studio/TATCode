extends Control

var is_mouse_inside_slot = [
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false
]

var slots = {
	"slot_1" : "",
	"slot_2" : "",
	"slot_3" : "",
	"slot_4" : "",
	"slot_5" : "",
	"slot_6" : "",
	"slot_7" : "",
	"slot_8" : "",
	"slot_9" : "",
	"slot_10" : "",
	"slot_11" : "",
	"slot_12" : "",
	"slot_13" : "",
	"slot_14" : "",
	"slot_15" : "",
	"slot_16" : "",
	"slot_17" : "",
	"slot_18" : "",
	"slot_19" : "",
	"slot_20" : ""
}

var currency = {
	"shuan": 1
}


func _ready():
	updateSlotIcon()

func updateSlotIcon():
	get_node("currency/currency_value_l").text = str(currency["shuan"])
	for a in slots:
		var item_icon = get_node("nine_patch_rect/grid_container/" + a + "/item")
		if(slots[a] == ""):
			item_icon.texture = null
		else:
			var icon_text = preload("res://Data/Textures/Items/Item1.png")
			item_icon.texture = icon_text 
			item_icon.region_enabled = true
			if(slots[a] == "wooden_sword"):
				item_icon.region_rect = Rect2(5, 165, 23, 24)
			elif(slots[a] == "iron_sword"):
				item_icon.region_rect = Rect2(35, 164, 26, 27)
			elif(slots[a] == "curved_sword"):
				item_icon.region_rect = Rect2(162, 164, 27, 28)
			elif(slots[a] == "battle_axe"):
				item_icon.region_rect = Rect2(354, 165, 27, 27)
			elif(slots[a] == "cloth_armor"):
				item_icon.region_rect = Rect2(291, 227, 27, 28)
			elif(slots[a] == "cloth_pants"):
				item_icon.region_rect = Rect2(326, 227, 22, 28)
			elif(slots[a] == "cloth_helmet"):
				item_icon.region_rect = Rect2(69, 228, 23, 27)
			elif(slots[a] == "health_potion"):
				item_icon.region_rect = Rect2(198, 609, 22, 32)
			elif(slots[a] == "stamina_potion"):
				item_icon.region_rect = Rect2(134, 609, 22, 32)
			elif(slots[a] == "apple"):
				item_icon.region_rect = Rect2(4, 451, 25, 28)

func addItem(item_name):
	var is_inventory_empty = false
	for i in slots:
		if(slots[i] == ""):
			slots[i] = item_name
			is_inventory_empty = true
			updateSlotIcon()
			break
	return is_inventory_empty

func handleVisibility():
	updateSlotIcon()
	if(visible == false):
		visible = true
	else:
		visible = false
		

func _input(_event):
	if(Input.is_action_just_pressed("Bag")):
		handleVisibility()
	if(visible):
		handleBag()

func handleBag():
	for i in is_mouse_inside_slot.size():
		if(is_mouse_inside_slot[i] == true):
			if(Input.is_action_just_pressed("PrimaryInteract")):
				if(slots["slot_" + str(i+1)] == "wooden_sword"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_1"]
					get_node("../character_page").slots["slot_1"] = "wooden_sword"
				elif(slots["slot_" + str(i+1)] == "iron_sword"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_1"]
					get_node("../character_page").slots["slot_1"] = "iron_sword"
				elif(slots["slot_" + str(i+1)] == "curved_sword"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_1"]
					get_node("../character_page").slots["slot_1"] = "curved_sword"
				elif(slots["slot_" + str(i+1)] == "battle_axe"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_1"]
					get_node("../character_page").slots["slot_1"] = "battle_axe"
				elif(slots["slot_" + str(i+1)] == "cloth_armor"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_2"]
					get_node("../character_page").slots["slot_2"] = "cloth_armor"
				elif(slots["slot_" + str(i+1)] == "cloth_pants"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_3"]
					get_node("../character_page").slots["slot_3"] = "cloth_pants"
				elif(slots["slot_" + str(i+1)] == "cloth_helmet"):
					slots["slot_" + str(i+1)] =  get_node("../character_page").slots["slot_4"]
					get_node("../character_page").slots["slot_4"] = "cloth_helmet"
				elif(slots["slot_" + str(i+1)] == "health_potion"):
					get_node("/root/TAT/player").info["stats"]["health"] += 25
					if(get_node("/root/TAT/player").info["stats"]["health"] > get_node("/root/TAT/player").info["stats"]["max_health"]):
						get_node("/root/TAT/player").info["stats"]["health"] = get_node("/root/TAT/player").info["stats"]["max_health"]
					slots["slot_" + str(i+1)] = ""
				elif(slots["slot_" + str(i+1)] == "stamina_potion"):
					get_node("/root/TAT/player").info["stats"]["stamina"] += 25
					if(get_node("/root/TAT/player").info["stats"]["stamina"] > get_node("/root/TAT/player").info["stats"]["max_stamina"]):
						get_node("/root/TAT/player").info["stats"]["stamina"] = get_node("/root/TAT/player").info["stats"]["max_stamina"]
					slots["slot_" + str(i+1)] = ""
				elif(slots["slot_" + str(i+1)] == "apple"):
					get_node("/root/TAT/player").info["stats"]["health"] += 10
					if(get_node("/root/TAT/player").info["stats"]["health"] > get_node("/root/TAT/player").info["stats"]["max_health"]):
						get_node("/root/TAT/player").info["stats"]["health"] = get_node("/root/TAT/player").info["stats"]["max_health"]
					get_node("/root/TAT/player").info["stats"]["stamina"] += 10
					if(get_node("/root/TAT/player").info["stats"]["stamina"] > get_node("/root/TAT/player").info["stats"]["max_stamina"]):
						get_node("/root/TAT/player").info["stats"]["stamina"] = get_node("/root/TAT/player").info["stats"]["max_stamina"]
					slots["slot_" + str(i+1)] = ""
				updateSlotIcon()
				get_node("../character_page").updateSlotIcon()
			elif(Input.is_action_just_pressed("SecondaryInteract")):
				slots["slot_" + str(i+1)] = ""
				updateSlotIcon()

func onSlot1MouseEntered():
	is_mouse_inside_slot[0] = true

func onSlot1MouseExited():
	is_mouse_inside_slot[0] = false

func onSlot2MouseEntered():
	is_mouse_inside_slot[1] = true

func onSlot2MouseExited():
	is_mouse_inside_slot[1] = false

func onSlot3MouseEntered():
	is_mouse_inside_slot[2] = true

func onSlot3MouseExited():
	is_mouse_inside_slot[2] = false

func onSlot4MouseEntered():
	is_mouse_inside_slot[3] = true

func onSlot4MouseExited():
	is_mouse_inside_slot[3] = false

func onSlot5MouseEntered():
	is_mouse_inside_slot[4] = true

func onSlot5MouseExited():
	is_mouse_inside_slot[4] = false

func onSlot6MouseEntered():
	is_mouse_inside_slot[5] = true

func onSlot6MouseExited():
	is_mouse_inside_slot[5] = false

func onSlot7MouseEntered():
	is_mouse_inside_slot[6] = true

func onSlot7MouseExited():
	is_mouse_inside_slot[6] = false

func onSlot8MouseEntered():
	is_mouse_inside_slot[7] = true

func onSlot8MouseExited():
	is_mouse_inside_slot[7] = false

func onSlot9MouseEntered():
	is_mouse_inside_slot[8] = true

func onSlot9MouseExited():
	is_mouse_inside_slot[8] = false

func onSlot10MouseEntered():
	is_mouse_inside_slot[9] = true

func onSlot10MouseExited():
	is_mouse_inside_slot[9] = false

func onSlot11MouseEntered():
	is_mouse_inside_slot[10] = true

func onSlot11MouseExited():
	is_mouse_inside_slot[10] = false

func onSlot12MouseEntered():
	is_mouse_inside_slot[11] = true

func onSlot12MouseExited():
	is_mouse_inside_slot[11] = false

func onSlot13MouseEntered():
	is_mouse_inside_slot[12] = true

func onSlot13MouseExited():
	is_mouse_inside_slot[12] = false

func onSlot14MouseEntered():
	is_mouse_inside_slot[13] = true

func onSlot14MouseExited():
	is_mouse_inside_slot[13] = false

func onSlot15MouseEntered():
	is_mouse_inside_slot[14] = true

func onSlot15MouseExited():
	is_mouse_inside_slot[14] = false

func onSlot16MouseEntered():
	is_mouse_inside_slot[15] = true

func onSlot16MouseExited():
	is_mouse_inside_slot[15] = false

func onSlot17MouseEntered():
	is_mouse_inside_slot[16] = true

func onSlot17MouseExited():
	is_mouse_inside_slot[16] = false

func onSlot18MouseEntered():
	is_mouse_inside_slot[17] = true

func onSlot18MouseExited():
	is_mouse_inside_slot[17] = false

func onSlot19MouseEntered():
	is_mouse_inside_slot[18] = true

func onSlot19MouseExited():
	is_mouse_inside_slot[18] = false

func onSlot20MouseEntered():
	is_mouse_inside_slot[19] = true

func onSlot20MouseExited():
	is_mouse_inside_slot[19] = false
