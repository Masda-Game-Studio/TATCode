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
	"Slot1" : "",
	"Slot2" : "",
	"Slot3" : "",
	"Slot4" : "",
	"Slot5" : "",
	"Slot6" : "",
	"Slot7" : "",
	"Slot8" : "",
	"Slot9" : "",
	"Slot10" : "",
	"Slot11" : "",
	"Slot12" : "",
	"Slot13" : "",
	"Slot14" : "",
	"Slot15" : "",
	"Slot16" : "",
	"Slot17" : "",
	"Slot18" : "",
	"Slot19" : "",
	"Slot20" : ""
}
func _ready():
	updateSlotIcon()

func updateSlotIcon():
	for a in slots:
		var item_icon = get_node("NinePatchRect/GridContainer/" + a + "/ItemIcon")
		if(slots[a] == ""):
			item_icon.texture = null
		else:
			var icon_text = preload("res://Data/Textures/Items/Items.png")
			item_icon.texture = icon_text 
			item_icon.region_enabled = true
			if(slots[a] == "wooden_sword"):
				item_icon.region_rect = Rect2(5, 165, 23, 24)

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
				if(slots["Slot" + str(i+1)] == "wooden_sword"):
					slots["Slot" + str(i+1)] =  get_node("../CharacterPage").slots["Slot1"]
					updateSlotIcon()
					get_node("../CharacterPage").slots["Slot1"] = "wooden_sword"
					get_node("../CharacterPage").updateSlotIcon()
			elif(Input.is_action_just_pressed("SecondaryInteract")):
				print("G PRESSED")
				slots["Slot" + str(i+1)] = ""
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
