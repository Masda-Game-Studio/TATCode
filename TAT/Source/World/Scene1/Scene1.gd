extends Control

var quest_page
func _ready():
	quest_page = get_node("/root/TAT/hud/quest")
	get_node("../player").position.x = 300
	get_node("../player").position.y = 670
#	var map_rect = get_node("tiles").get_used_rect()
#	var tile_size = get_node("tiles").cell_quadrant_size
#	var world_size_pixel = map_rect.size * tile_size
#	get_node("../player/camera").limit_right = world_size_pixel.x - 20
#	get_node("../player/camera").limit_bottom = world_size_pixel.y + 45

func _process(_delta):
	questHandler()

var quests = {
	"quest_1" : {
		"title" : "Find Village leader",
		"description": "Go north of the village and find the village leader",
		"objective_description" : "Find Village leader",
		"reward" : 10,
		"reward_description" : "Reward: ",
		"objective" : 0,
		"max_objective" : 1,
		"is_available" : true,
		"is_active" : false,
		"is_completed" : false,
		"path" : "/root/TAT/scene_1",
		"name" : "quest_1"
	},
	"quest_2" : {
		"title" : "Enemies at the gate",
		"description": "Go south and kill 2 enemies",
		"objective_description" : "kill the bandits",
		"reward" : 10,
		"reward_description" : "Reward: ",
		"objective" : 0,
		"max_objective" : 2,
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "/root/TAT/scene_1",
		"name" : "quest_2"
	},
	"quest_3" : {
		"title" : "Let the army know",
		"description": "Go south of here and pass the gates, You'll see an army camp. Give the guards this letter.",
		"objective_description" : "Deliver the message",
		"reward" : 20,
		"reward_description" : "Reward: ",
		"objective" : 0,
		"max_objective" : 1,
		"is_available" : false,
		"is_active" : false,
		"is_completed" : false,
		"path" : "/root/TAT/scene_1",
		"name" : "quest_3"
	}
}


func questHandler():
	quest1Handler()
	quest2Handler()
	quest3Handler()
func quest1Handler():
	if(!quests["quest_1"]["is_completed"]):
		if(quest_page != null):
			if(quests["quest_1"]["is_available"]):
				if(get_node("villager_1").is_body_inside):
					get_node("villager_1/primary_interaction_t").visible = true
					if(Input.is_action_just_pressed("PrimaryInteract")):
						quest_page.addQuest(quests["quest_1"])
				else:
					get_node("villager_1/primary_interaction_t").visible = false
			elif(quests["quest_1"]["is_active"]):
				get_node("villager_1/quest_mark").visible = false
				get_node("villager_1/primary_interaction_t").visible = false
				if(get_node("village_leader").is_body_inside):
					quests["quest_1"]["is_active"] = false
					quests["quest_1"]["objective"] = 1
					quest_page.updateQuest(quests["quest_1"])
	elif(!quests["quest_2"]["is_available"] && !quests["quest_2"]["is_active"] && !quests["quest_2"]["is_completed"]):
		quests["quest_2"]["is_available"] = true

func quest2Handler():
	if(!quests["quest_2"]["is_completed"]):
		if(quest_page != null):
			if(quests["quest_2"]["is_available"]):
				get_node("village_leader/quest_mark").visible = true
				if(get_node("village_leader").is_body_inside):
					get_node("village_leader/primary_interaction_t").visible = true
					if(Input.is_action_just_pressed("PrimaryInteract")):
						quest_page.addQuest(quests["quest_2"])
				else:
					get_node("village_leader/primary_interaction_t").visible = false
			elif(quests["quest_2"]["is_active"]):
				get_node("village_leader/quest_mark").visible = false
				get_node("village_leader/primary_interaction_t").visible = false
				if(quests["quest_2"]["objective"] == quests["quest_2"]["max_objective"] ):
					quests["quest_2"]["is_active"] = false
					quest_page.updateQuest(quests["quest_2"])
	if(!quests["quest_3"]["is_available"] && !quests["quest_3"]["is_active"] && !quests["quest_3"]["is_completed"] && quests["quest_2"]["is_completed"]):
		quests["quest_3"]["is_available"] = true

func quest3Handler():
	if(!quests["quest_3"]["is_completed"]):
		if(quest_page != null):
			if(quests["quest_3"]["is_available"]):
				get_node("village_leader/quest_mark").visible = true
				if(get_node("village_leader").is_body_inside):
					get_node("village_leader/primary_interaction_t").visible = true
					if(Input.is_action_just_pressed("PrimaryInteract")):
						quest_page.addQuest(quests["quest_3"])
				else:
					get_node("village_leader/primary_interaction_t").visible = false
			elif(quests["quest_3"]["is_active"]):
				get_node("village_leader/quest_mark").visible = false
				get_node("village_leader/primary_interaction_t").visible = false
				if(get_node("southern_gate").is_body_inside):
					quests["quest_3"]["is_active"] = false
					quests["quest_3"]["objective"] = 1
					quest_page.updateQuest(quests["quest_3"])
	else:
		var Scene2 = preload("res://Source/World/Scene2/Scene2.tscn")
		var scene_2 = Scene2.instantiate()
		scene_2.set_name("scene_2")
		get_node("/root/TAT").add_child(scene_2)
		get_node("../player").position.x = 1000
		get_node("../player").position.y = 300
		queue_free()

func onBandit1Dead():
	if(quests["quest_2"]["is_active"]):
		if(quests["quest_2"]["objective"] < quests["quest_2"]["max_objective"]):
			quests["quest_2"]["objective"] +=1
			quest_page.updateQuest(quests["quest_2"])
