extends Control

var is_mouse_inside_slot = [
	false,
	false,
	false,
	false
]
var slots = {
	"slot_1" : "",
	"slot_2" : "",
	"slot_3" : "",
	"slot_4" : ""
}

var armor = {
	"cloth_helmet" : {
		"health" : 10,
		"stamina" : 30,
		"cooldown" : 0,
		"cost" : 0
	},
	"cloth_pants" : {
		"health" : 25,
		"stamina" : 10,
		"cooldown" : 0,
		"cost" : 0
	},
	"cloth_armor" : {
		"health" : 40,
		"stamina" : 20,
		"cooldown" : 0,
		"cost" : 0
	}
}
var base_info = {
	"stats" : {
		"health" : 100,
		"stamina" : 100,
		"stamina_regen" : 10,
		"health_regen" : 10,
		"max_health" : 100,
		"max_stamina" : 100
	}
}
var stats = {
	"armor" : {
		"health" : 0,
		"stamina" : 0
	},
	"pants" : {
		"health" : 0,
		"stamina" : 0
	},
	"helmet" : {
		"health" : 0,
		"stamina" : 0
	},

}

func updateStats():
	if(slots["slot_2"] == "cloth_armor"):
		stats["armor"]["health"] = armor["cloth_armor"]["health"]
		stats["armor"]["stamina"] = armor["cloth_armor"]["stamina"]
	elif(slots["slot_2"] == ""):
		stats["armor"]["health"] = 0
		stats["armor"]["stamina"] = 0
	if(slots["slot_3"] == "cloth_pants"):
		stats["pants"]["health"] = armor["cloth_pants"]["health"]
		stats["pants"]["stamina"] = armor["cloth_pants"]["stamina"]
	elif(slots["slot_3"] == ""):
		stats["pants"]["health"] = 0
		stats["pants"]["stamina"] = 0
	if(slots["slot_4"] == "cloth_helmet"):
		stats["helmet"]["health"] = armor["cloth_pants"]["health"]
		stats["helmet"]["stamina"] = armor["cloth_pants"]["stamina"]
	elif(slots["slot_4"] == ""):
		stats["helmet"]["health"] = 0
		stats["helmet"]["stamina"] = 0
	var added_health = stats["armor"]["health"] + stats["pants"]["health"] + stats["helmet"]["health"]
	var added_stamina = stats["armor"]["stamina"] + stats["pants"]["stamina"] + stats["helmet"]["stamina"]
	get_node("/root/TAT/player").info["stats"]["max_health"] = added_health + base_info["stats"]["health"]
	get_node("/root/TAT/player").info["stats"]["max_stamina"] = added_stamina + base_info["stats"]["stamina"]
	if(get_node("/root/TAT/player").info["stats"]["health"] > get_node("/root/TAT/player").info["stats"]["max_health"]):
		get_node("/root/TAT/player").info["stats"]["health"] = get_node("/root/TAT/player").info["stats"]["max_health"]
	if (get_node("/root/TAT/player").info["stats"]["stamina"] > get_node("/root/TAT/player").info["stats"]["max_stamina"]):
		get_node("/root/TAT/player").info["stats"]["stamina"] = get_node("/root/TAT/player").info["stats"]["max_stamina"]
func _ready():
	updateSlotIcon()
	# each slot has a unique background
#	var icon_text = preload("res://Data/Textures/Items/Items.png")
#	get_node("NinePatchRect/Slot1/BackgroundIcon").texture = icon_text
#	get_node("NinePatchRect/Slot1/BackgroundIcon").region_rect = Rect2(290, 165, 27, 27)
#	get_node("NinePatchRect/Slot2/BackgroundIcon").texture = icon_text
#	get_node("NinePatchRect/Slot2/BackgroundIcon").region_rect = Rect2(164, 228, 26, 27)
#	get_node("NinePatchRect/Slot3/BackgroundIcon").texture = icon_text
#	get_node("NinePatchRect/Slot3/BackgroundIcon").region_rect = Rect2(326, 227, 22, 28)
#	get_node("NinePatchRect/Slot4/BackgroundIcon").texture = icon_text
#	get_node("NinePatchRect/Slot4/BackgroundIcon").region_rect = Rect2(196, 259, 25, 28)

func updateSlotIcon():
	var icon_text = preload("res://Data/Textures/Items/Item1.png")
	var item_icon 
	var bottom_bar_icon
	for a in slots:
		item_icon = get_node("nine_patch_rect/" + a + "/item")
		bottom_bar_icon = get_node("/root/TAT/hud/bottom_bar/" + a +"/item" )
		if(slots[a] == ""):
			bottom_bar_icon.texture = null
			item_icon.texture = null
		else:
			item_icon.texture = icon_text 
			bottom_bar_icon.texture = icon_text
			if(slots[a] == "wooden_sword"):
				item_icon.region_rect = Rect2(5, 165, 23, 24)
				bottom_bar_icon.region_rect = Rect2(5, 165, 23, 24)
			elif(slots[a] == "iron_sword"):
				item_icon.region_rect = Rect2(35, 164, 26, 27)
				bottom_bar_icon.region_rect = Rect2(35, 164, 26, 27)
			elif(slots[a] == "curved_sword"):
				item_icon.region_rect = Rect2(162, 164, 27, 28)
				bottom_bar_icon.region_rect = Rect2(162, 164, 27, 28)
			elif(slots[a] == "battle_axe"):
				item_icon.region_rect = Rect2(354, 165, 27, 27)
				bottom_bar_icon.region_rect = Rect2(354, 165, 27, 27)
			elif(slots[a] == "cloth_armor"):
				item_icon.region_rect = Rect2(291, 227, 27, 28)
				bottom_bar_icon.region_rect = Rect2(291, 227, 27, 28)
			elif(slots[a] == "cloth_pants"):
				item_icon.region_rect = Rect2(326, 227, 22, 28)
				bottom_bar_icon.region_rect = Rect2(326, 227, 22, 28)
			elif(slots[a] == "cloth_helmet"):
				item_icon.region_rect = Rect2(69, 228, 23, 27)
				bottom_bar_icon.region_rect = Rect2(69, 228, 23, 27)
			elif(slots[a] == "health_potion"):
				item_icon.region_rect = Rect2(198, 609, 22, 32)
				bottom_bar_icon.region_rect = Rect2(198, 609, 22, 32)
			elif(slots[a] == "stamina_potion"):
				item_icon.region_rect = Rect2(134, 609, 22, 32)
				bottom_bar_icon.region_rect = Rect2(134, 609, 22, 32)
			elif(slots[a] == "apple"):
				item_icon.region_rect = Rect2(4, 451, 25, 28)
				bottom_bar_icon.region_rect = Rect2(4, 451, 25, 28)


func handleVisibility():
	updateSlotIcon()
	if(visible == false):
		visible = true
	else:
		visible = false

func _input(_event):
	if(Input.is_action_just_pressed("CharacterPage")):
		handleVisibility()
	if(visible):
		handleCharacterPage()
	updateStats()


func handleCharacterPage():
	for a in is_mouse_inside_slot.size():
		if(is_mouse_inside_slot[a] == true):
			if(Input.is_action_just_pressed("PrimaryInteract")):
				var bag_slots = get_node("../bag").slots
				for i in bag_slots:
					if(bag_slots[i] == ""):
						bag_slots[i] = slots["slot_" + str(a+1)]
						slots["slot_" + str(a+1)] = ""
						updateSlotIcon()
						get_node("../bag").updateSlotIcon()
						break
			elif(Input.is_action_just_pressed("SecondaryInteract")):
				slots["slot_" + str(a+1)] = ""
			updateSlotIcon()

func onWeaponSlotMouseEntered():
	is_mouse_inside_slot[0] = true

func onWeaponSlotMouseExited():
	is_mouse_inside_slot[0] = false

func onBodySlotMouseEntered():
	is_mouse_inside_slot[1] = true

func onBodySlotMouseExited():
	is_mouse_inside_slot[1] = false

func onPantsSlotMouseEntered():
	is_mouse_inside_slot[2] = true

func onPantsSlotMouseExited():
	is_mouse_inside_slot[2] = false

func onNecklaceSlotMouseEntered():
	is_mouse_inside_slot[3] = true

func onNecklaceSlotMouseExited():
	is_mouse_inside_slot[3] = false
