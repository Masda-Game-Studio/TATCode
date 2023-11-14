extends Control

var is_mouse_inside_slot = [
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
	"slot_8" : ""
}

func _ready():
	updateSlotIcon()

func updateSlotIcon():
	var icon_text = preload("res://Data/Textures/Items/Item1.png")
	var item_icon 
	for a in slots:
		item_icon = get_node("nine_patch_rect/" + a + "/item")
		if(slots[a] == ""):
			item_icon.texture = null
		else:
			item_icon.texture = icon_text 
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

func chestManager():
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

func _input(_event):
	if (visible):
		updateSlotIcon()
		chestManager()
func onExitBPressed():
	visible = false


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
