extends Control

var quest_page

func _ready():
	quest_page = get_node("/root/TAT/hud/quest")

var quests = {
	"quest_1" : {
		"title" : "Find the guard",
		"description": "deliver the letter to the guard at the south",
		"objective_description" : "Find the guard",
		"reward" : 100,
		"reward_description" : "Reward: ",
		"objective" : 0,
		"max_objective" : 1,
		"is_available" : true,
		"is_active" : false,
		"is_completed" : false,
		"path" : "/root/TAT/scene_2",
		"name" : "quest_1"
	}
}

func _process(_delta):
	questHandler()

func questHandler():
	quest1Handler()

func quest1Handler():
	if(!quests["quest_1"]["is_completed"]):
		if(quest_page != null):
			if(quests["quest_1"]["is_available"]):
				get_node("guard/quest_mark").visible = true
				if(get_node("guard").is_body_inside):
					get_node("guard/primary_interaction_t").visible = true
					if(Input.is_action_just_pressed("PrimaryInteract")):
						quest_page.addQuest(quests["quest_1"])
				else:
					get_node("guard/primary_interaction_t").visible = false
			elif(quests["quest_1"]["is_active"]):
				get_node("guard/quest_mark").visible = false
				get_node("guard/primary_interaction_t").visible = false
				if(get_node("guard_2").is_body_inside):
					quests["quest_1"]["is_active"] = false
					quests["quest_1"]["objective"] = 1
					quest_page.updateQuest(quests["quest_1"])
					get_tree().quit()

