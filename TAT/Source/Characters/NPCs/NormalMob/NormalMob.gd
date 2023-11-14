extends CharacterBody2D

#detection
#the distance that npc will follow you
var teritory = 250
var respawn_point = Vector2( 0, 0)
var is_chasing_body = false
var is_going_to_respawn_point = false
var is_damaging = false
signal is_dead
var hostile_body = null
var speed = 90
var direction = Vector2(0, 0)
var sprite = null
var current_speed = speed
var inventory = {
	"slot_1" : "health_potion",
	"slot_2" : "stamina_potion",
	"slot_3" : "battle_axe",
	"slot_4" : "",
	"slot_5" : "",
	"slot_6" : "",
	"slot_7" : "",
	"slot_8" : ""
}
var info = {
	"stats" : {
		"health" : 65,
		"stamina" : 65,
		"stamina_regen" : 10,
		"health_regen" : 10,
		"max_health" : 65,
		"max_stamina" : 65,
	}
}

func updateStats():
	get_node("health_bar/health_l").text = str(info["stats"]["health"])
	get_node("health_bar/max_health_l").text = str(info["stats"]["max_health"])
	get_node("stamina_bar/stamina_l").text = str(info["stats"]["stamina"])
	get_node("stamina_bar/max_stamina_l").text = str(info["stats"]["max_stamina"])
func onDead():
	if(info["stats"]["health"] < 0):
		global_position = respawn_point
		is_chasing_body = false
		visible =false
		info["stats"]["health"] = info["stats"]["max_health"]
		info["stats"]["stamina"] = info["stats"]["max_stamina"]
		get_node("damage_timer").stop()
		get_node("respawn_timer").start()
		is_dead.emit()
		get_node("/root/TAT/hud/inventory/chest").visible = true
		for slot in inventory:
			get_node("/root/TAT/hud/inventory/chest").slots[slot] = inventory[slot]

		
func _ready():
	sprite = get_node("sprite")
	sprite.animation = "DOWN_IDLE"
	sprite.play()
	respawn_point = global_position


func onBodyEntered(body):
	if(body == get_node("/root/TAT/player")):
		if(!is_going_to_respawn_point):
			is_chasing_body = true
			hostile_body = body


func detectionManager():
	if(hostile_body != null):
		if(is_chasing_body):
			direction = (hostile_body.global_position - global_position).normalized()
			velocity = direction * current_speed
			move_and_slide()
			if (global_position.distance_to(hostile_body.global_position) < 40):
				current_speed = 0
				if (is_damaging == false):
					get_node("damage_timer").start()
					is_damaging = true
			else:
				current_speed = speed
		if (global_position.distance_to(hostile_body.global_position) > 40):
			get_node("damage_timer").stop()
			is_damaging = false
		if(global_position.distance_to(respawn_point) > teritory):
			is_chasing_body = false
			is_going_to_respawn_point = true
			if(info["stats"]["health"] <= info["stats"]["max_health"] - 20):
				info["stats"]["health"] += 20
			if(info["stats"]["stamina"] <= info["stats"]["max_stamina"] - 20):
				info["stats"]["stamina"] += 20
		if(is_going_to_respawn_point):
			direction = (respawn_point - global_position).normalized()
			velocity = direction * speed
			move_and_slide()
			if(global_position.distance_to(respawn_point) <= 3):
				global_position = respawn_point
				is_going_to_respawn_point = false
				info["stats"]["health"] = info["stats"]["max_health"]
				sprite.animation = "DOWN_IDLE"
func _physics_process(_delta):
	detectionManager()

func _process(_delta):
	updateStats()
	onDead()
	animationWalkingManager()
	animationAttackingManager()


func onDamageTimerTimeout():
	if(hostile_body.info["stats"]["health"] > 0):
		if(info["stats"]["stamina"] > 2):
			hostile_body.info["stats"]["health"] -= 5
			info["stats"]["stamina"] -= 3


func onRespawnTimerTimeout():
	visible = true


func animationWalkingManager():
	if(sprite != null):
		if(is_damaging == false):
			sprite.scale = Vector2(0.17 , 0.17)
			if(rad_to_deg(direction.angle()) < -67.5 && rad_to_deg(direction.angle()) > -112.5):
				sprite.animation = "UP_WALK"
			elif(rad_to_deg(direction.angle()) < -22.5 && rad_to_deg(direction.angle()) > -67.5):
				sprite.animation = "RIGHT_UP_WALK"
				sprite.flip_h = false
			elif(rad_to_deg(direction.angle()) < 22.5 && rad_to_deg(direction.angle()) > -22.5):
				sprite.animation = "LEFT_WALK"
				sprite.flip_h = true
			elif(rad_to_deg(direction.angle()) < 67.5 && rad_to_deg(direction.angle()) > 22.5):
				sprite.animation = "LEFT_DOWN_WALK"
				sprite.flip_h = true
			elif(rad_to_deg(direction.angle()) < 112.5 && rad_to_deg(direction.angle()) > 67.5):
				sprite.animation = "DOWN_WALK"
			elif(rad_to_deg(direction.angle()) < 157.5 && rad_to_deg(direction.angle()) > 112.5):
				sprite.animation = "LEFT_DOWN_WALK"
				sprite.flip_h = false
			elif(rad_to_deg(direction.angle()) < -157.5  || rad_to_deg(direction.angle()) > 157.5):
				sprite.animation = "LEFT_WALK"
				sprite.flip_h = false
			elif(rad_to_deg(direction.angle()) < -112.5 && rad_to_deg(direction.angle()) > -157.5):
				sprite.animation = "RIGHT_UP_WALK"
				sprite.flip_h = true
			if(velocity == Vector2(0, 0)):
				sprite.animation = "DOWN_IDLE"

func animationAttackingManager():
	if(sprite != null):
		if(is_damaging == true):
			sprite.scale = Vector2(0.23 , 0.23)
			if(sprite.animation == "UP_WALK"):
				sprite.animation = "UP_ATTACK"
			elif(sprite.animation == "RIGHT_UP_WALK" && sprite.flip_h == false):
				sprite.animation = "RIGHT_UP_ATTACK"
			elif(sprite.animation == "LEFT_WALK" && sprite.flip_h == true):
				sprite.animation = "RIGHT_ATTACK"
				sprite.flip_h = false
			elif(sprite.animation == "LEFT_DOWN_WALK" && sprite.flip_h == true):
				sprite.animation = "RIGHT_DOWN_ATTACK"
				sprite.flip_h = false
			elif(sprite.animation == "DOWN_WALK"):
				sprite.animation = "DOWN_ATTACK"
			elif(sprite.animation == "LEFT_DOWN_WALK" && sprite.flip_h == false):
				sprite.animation = "LEFT_DOWN_ATTACK"
			elif(sprite.animation == "LEFT_WALK" && sprite.flip_h == false):
				sprite.animation = "LEFT_ATTACK"
			elif(sprite.animation == "RIGHT_UP_WALK" && sprite.flip_h == true):
				sprite.animation = "LEFT_UP_ATTACK"
				sprite.flip_h = false

