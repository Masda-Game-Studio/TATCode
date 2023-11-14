extends CharacterBody2D

var player_sprite
var speed = 80
var input_direction 
var last_direction
var is_body_in_range = false
var is_movement_locked = false
var is_first_ability_on_cooldown = false
var current_weapon = null
var info = {
	"stats" : {
		"health" : 100,
		"stamina" : 100,
		"stamina_regen" : 10,
		"health_regen" : 10,
		"max_health" : 100,
		"max_stamina" : 100
	}
}


var weapon = {
	"wooden_sword" : {
		"damage" : 2,
		"cooldown" : 3,
		"cost" : 4
	},
	"iron_sword" : {
		"damage" : 4,
		"cooldown" : 2.5,
		"cost" : 6
	},
	"curved_sword" : {
		"damage" : 6,
		"cooldown" : 2,
		"cost" : 8
	},
	"battle_axe" : {
		"damage" : 20,
		"cooldown" : 4,
		"cost" : 14
	}
}

func _ready():
	player_sprite = get_node("sprite")
	player_sprite.animation = "down_idle"
	player_sprite.play()

func handleMovement():
	if(!is_movement_locked):
		input_direction = Vector2(
			Input.get_action_strength("Right") - Input.get_action_strength("Left"),
			Input.get_action_strength("Down") - Input.get_action_strength("Up")
		)
		velocity = input_direction * speed
		move_and_slide()

func handleAnimation():
	if(input_direction ==Vector2(0,-1)):
		player_sprite.animation = "up_walk"
	elif(input_direction ==Vector2(0,1)):
		player_sprite.animation = "down_walk"
	elif(input_direction ==Vector2(-1,0)):
		player_sprite.animation = "left_walk"
	elif(input_direction ==Vector2(1,0)):
		player_sprite.animation = "right_walk"
	elif(input_direction ==Vector2(1,-1)):
		player_sprite.animation = "right_up_walk"
	elif(input_direction ==Vector2(1,1)):
		player_sprite.animation = "right_down_walk"
	elif(input_direction ==Vector2(-1,-1)):
		player_sprite.animation = "left_up_walk"
	elif(input_direction ==Vector2(-1,1)):
		player_sprite.animation = "left_down_walk"
	elif(input_direction == Vector2(0,0)):
		var sprite = get_node("sprite")
		if( sprite.animation == "up_walk"):
			player_sprite.animation = "up_idle"
		elif(sprite.animation == "down_walk"):
			player_sprite.animation = "down_idle"
		elif(sprite.animation == "left_walk"):
			player_sprite.animation = "left_idle"
		elif(sprite.animation == "right_walk"):
			player_sprite.animation = "right_idle"
		elif(sprite.animation == "right_up_walk"):
			player_sprite.animation = "right_up_idle"
		elif(sprite.animation == "right_down_walk"):
			player_sprite.animation = "right_down_idle"
		elif(sprite.animation == "left_up_walk"):
			player_sprite.animation = "left_up_idle"
		elif(sprite.animation == "left_down_walk"):
			player_sprite.animation = "left_down_idle"

func _process(_delta):
	handleMovement()
	handleAnimation()
func _input(_event):
	abilityManager()

func abilityManager():
	if (Input.is_action_just_pressed("FirstAbility") && is_body_in_range):
		if(get_node("/root/TAT/hud/inventory/character_page").slots["slot_1"] == "wooden_sword"):
			current_weapon = weapon["wooden_sword"]
		elif (get_node("/root/TAT/hud/inventory/character_page").slots["slot_1"] == "iron_sword"):
			current_weapon = weapon["iron_sword"]
		elif (get_node("/root/TAT/hud/inventory/character_page").slots["slot_1"] == "curved_sword"):
			current_weapon = weapon["curved_sword"]
		elif (get_node("/root/TAT/hud/inventory/character_page").slots["slot_1"] == "battle_axe"):
			current_weapon = weapon["battle_axe"]
		if(!is_first_ability_on_cooldown && current_weapon != null):
			if((npc.get_parent()).info["stats"]["health"] > 0 && info["stats"]["stamina"] >= current_weapon["cost"] ):
				is_first_ability_on_cooldown = true
				first_ability_cooldown = current_weapon["cooldown"]
				npc.get_parent().info["stats"]["health"] -= current_weapon["damage"]
				info["stats"]["stamina"] -= current_weapon["cost"]
				get_node("/root/TAT/hud/bottom_bar/slot_1/cooldown_background/cooldown_l").text = str(current_weapon["cooldown"])
				get_node("/root/TAT/hud/bottom_bar/slot_1/cooldown_background").visible = true
				get_node("first_ability_cooldown_timer").start()



var npc
func onBodyEntered(body):
	if (body.name =="collision_area"):
		npc = body
		is_body_in_range = true


func onBodyExited(body):
	if (body.name =="collision_area"):
		is_body_in_range = false


func onHealthRegenerationTimerTimeout():
	if(info["stats"]["health"] < info["stats"]["max_health"]):
		info["stats"]["health"] +=0.5


func onStaminaRegenerationTimerTimeout():
	if(info["stats"]["stamina"] < info["stats"]["max_stamina"]):
		info["stats"]["stamina"] +=0.5

var first_ability_cooldown = 0
func onFirstAbilityCooldownTimerTimeout():
	first_ability_cooldown -= 0.5
	get_node("/root/TAT/hud/bottom_bar/slot_1/cooldown_background/cooldown_l").text = str(first_ability_cooldown)
	if(first_ability_cooldown == 0):
		get_node("/root/TAT/hud/bottom_bar/slot_1/cooldown_background").visible = false
		is_first_ability_on_cooldown = false
		first_ability_cooldown = current_weapon["cooldown"]
		get_node("first_ability_cooldown_timer").stop()
