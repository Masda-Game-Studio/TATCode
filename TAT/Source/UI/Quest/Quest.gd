extends Control

func _input(_event):
	if(Input.is_action_just_pressed("Quest")):
		visible = !visible

var slot = {
	"slot_1" : {
		"title" : "",
		"description" : "",
		"objective" : 0,
		"objective_description" : "",
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_2" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_3" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_4" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_5" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_6" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_7" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	},
	"slot_8" : {
		"title" : "",
		"description" : "",
		"objective_description" : "",
		"objective" : 0,
		"max_objective" : 0,
		"reward" : 0,
		"reward_description" : "",
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "",
		"name" : ""
	}
}
var active_slot = ""
var temp_slot = {
	"title" : "",
	"description" : "",
	"objective_description" : "",
	"objective" : 0,
	"max_objective" : 0,
	"reward" : 0,
	"reward_description" : "",
	"is_available" : false,
	"is_active" : false,
	"is_completed" : false,
	"path" : "",
	"name" : ""
}
func addQuest(quest):
	temp_slot = quest
	get_node("quest_page/title_l").text = quest["title"]
	get_node("quest_page/description_l").text = quest["description"]
	get_node("quest_page/objective_description_l").text = quest["objective_description"]
	get_node("quest_page/objective_l").text = str(quest["objective"])
	get_node("quest_page/max_objective_l").text = str(quest["max_objective"])
	get_node("quest_page/reward_l").text = str(quest["reward"])
	get_node("quest_page/reward_description_l").text = quest["reward_description"]
	get_node("quest_page/accept_background").visible = true
	get_node("quest_page/complete_background").visible = false
	get_node("quest_page").visible = true

func onAcceptBPressed():
	var is_empty = false
	for slot_n in slot:
		if(slot[slot_n]["title"] ==""):
			slot[slot_n] = temp_slot
			is_empty = true
			slot[slot_n]["is_available"] = false
			slot[slot_n]["is_active"] = true
			get_node(slot[slot_n]["path"]).quests[slot[slot_n]["name"]] = slot[slot_n]
			get_node("nine_patch_rect/grid_container/" + slot_n + "/quest_b").text = slot[slot_n]["title"]
			get_node("nine_patch_rect/grid_container/" + slot_n).visible = true
			get_node("quest_page/accept_background").visible = false
			get_node("quest_page").visible = false
			break
	if(!is_empty):
		get_node("quest_message").visible = true
		get_node("quest_message_timer").start()

func onQuestMessageTimerTimeout():
	get_node("quest_message").visible = false

func onQuestPageExitBPressed():
	get_node("quest_page").visible = false

func updateQuest(quest):
	for slot_n in slot:
		if (slot[slot_n]["title"] == quest["title"]):
			slot[slot_n] = quest
			updateQuestDetails(slot_n)
			active_slot = slot_n
			if(slot[slot_n]["objective"] == slot[slot_n]["max_objective"]):
				get_node("quest_page/complete_background").visible = true
			else:
				get_node("quest_page/complete_background").visible = false
			break

func onCompleteBPressed():
	get_node("quest_page").visible = false
	get_node("quest_page/complete_background").visible = false
	slot[active_slot]["title"] = ""
	get_node("nine_patch_rect/grid_container/" + active_slot + "/quest_b").text = ""
	get_node("nine_patch_rect/grid_container/" + active_slot).visible = false
	slot[active_slot]["is_completed"] = true
	get_node(slot[active_slot]["path"]).quests[slot[active_slot]["name"]] = slot[active_slot]
	get_node("/root/TAT/hud/inventory/bag").currency["shuan"] += slot[active_slot]["reward"]



func updateQuestDetails(slot_n):
	get_node("quest_page/title_l").text = slot[slot_n]["title"]
	get_node("quest_page/description_l").text = slot[slot_n]["description"]
	get_node("quest_page/objective_description_l").text = slot[slot_n]["objective_description"]
	get_node("quest_page/objective_l").text = str(slot[slot_n]["objective"])
	get_node("quest_page/max_objective_l").text = str(slot[slot_n]["max_objective"])
	get_node("quest_page/reward_l").text = str(slot[slot_n]["reward"])
	get_node("quest_page/reward_description_l").text = slot[slot_n]["reward_description"]


func questSlotVisibilityHandler(slot_n):
	if(slot[slot_n]["title"] == get_node("quest_page/title_l").text):
		get_node("quest_page").visible = !(get_node("quest_page").visible)
	else:
		get_node("quest_page").visible = true
		updateQuestDetails(slot_n)
		active_slot = slot_n
		if(slot[slot_n]["objective"] == slot[slot_n]["max_objective"]):
			get_node("quest_page/complete_background").visible = true
		else:
			get_node("quest_page/complete_background").visible = false

func onQuest1BPressed():
	questSlotVisibilityHandler("slot_1")

func onQuest2BPressed():
	questSlotVisibilityHandler("slot_2")

func onQuest3BPressed():
	questSlotVisibilityHandler("slot_3")

func onQuest4BPressed():
	questSlotVisibilityHandler("slot_4")

func onQuest5BPressed():
	questSlotVisibilityHandler("slot_5")

func onQuest6BPressed():
	questSlotVisibilityHandler("slot_6")

func onQuest7BPressed():
	questSlotVisibilityHandler("slot_7")

func onQuest8BPressed():
	questSlotVisibilityHandler("slot_8")
