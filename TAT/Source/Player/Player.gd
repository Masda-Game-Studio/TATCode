extends CharacterBody2D

var speed = 80
var sprite
var input_direction 
var last_direction
var is_movement_locked = false
var info = {
	"stats" : {
		"health" : 100,
		"stamina" : 100,
		"stamina_regen" : 10,
		"health_regen" : 10,
		"max_health" : 120,
		"max_stamina" : 120,
	}
}
func _ready():
	sprite = get_node("Sprite")
	sprite.animation = "DOWN_IDLE"
	sprite.play()

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
		sprite.animation = "UP_WALK"
		last_direction = "up"
	elif(input_direction ==Vector2(0,1)):
		sprite.animation = "DOWN_WALK"
		last_direction = "down"
	elif(input_direction ==Vector2(-1,0)):
		sprite.animation = "SIDE_WALK"
		last_direction = "left"
		sprite.flip_h = true
	elif(input_direction ==Vector2(1,0)):
		sprite.animation = "SIDE_WALK"
		last_direction = "right"
		sprite.flip_h = false
		
	elif(input_direction ==Vector2(1,-1)):
		sprite.animation = "SIDE_TOP_WALK"
		last_direction = "right"
		sprite.flip_h = false
	elif(input_direction ==Vector2(1,1)):
		sprite.animation = "SIDE_BOTTOM_WALK"
		last_direction = "right"
		sprite.flip_h = true
	elif(input_direction ==Vector2(-1,-1)):
		sprite.animation = "SIDE_TOP_WALK"
		last_direction = "left"
		sprite.flip_h = true
	elif(input_direction ==Vector2(-1,1)):
		sprite.animation = "SIDE_BOTTOM_WALK"
		last_direction = "left"
		sprite.flip_h = false
	elif(input_direction == Vector2(0,0)):
		if(last_direction == "up"):
			sprite.animation = "UP_IDLE"
		elif(last_direction == "down"):
			sprite.animation = "DOWN_IDLE"
		elif(last_direction == "left"):
			sprite.animation = "SIDE_IDLE"
			sprite.flip_h = false
		elif(last_direction == "right"):
			sprite.animation = "SIDE_IDLE"
			sprite.flip_h = true


func _input(event):

	handleMovement()

func _process(_delta):
	handleAnimation()

