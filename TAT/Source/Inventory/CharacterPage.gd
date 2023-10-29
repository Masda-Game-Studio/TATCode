extends Control

var is_mouse_inside_slot = [
	false,
	false,
	false,
	false
]
var slots = {
	"Slot1" : "wooden_sword",
	"Slot2" : "",
	"Slot3" : "",
	"Slot4" : ""
}

func _ready():
	updateSlotIcon()
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
	for a in slots:
		if(slots[a] == ""):
			var item_icon = get_node("NinePatchRect/" + a + "/ItemIcon")
			item_icon.texture = null
		else:
			var item_icon = get_node("NinePatchRect/" + a + "/ItemIcon")
			var icon_text = preload("res://Data/Textures/Items/Items.png")
			item_icon.texture = icon_text 
			item_icon.region_enabled = true
			if(slots[a] == "wooden_sword"):
				item_icon.region_rect = Rect2(5, 165, 23, 24)

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

func handleCharacterPage():
	for a in is_mouse_inside_slot.size():
		if(is_mouse_inside_slot[a] == true):
			if(Input.is_action_just_pressed("PrimaryInteract")):
				var bag_slots = get_node("../Bag").slots
				for i in bag_slots:
					if(bag_slots[i] == ""):
						bag_slots[i] = slots["Slot" + str(a+1)]
						slots["Slot" + str(a+1)] = ""
						updateSlotIcon()
						get_node("../Bag").updateSlotIcon()
						break
			elif(Input.is_action_just_pressed("SecondaryInteract")):
				slots["Slot" + str(a+1)] = ""
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
