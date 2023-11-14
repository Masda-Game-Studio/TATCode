extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_event):
	if(Input.is_action_just_pressed("ESCAPE")):
		visible = !visible


func onResumeBPressed():
	visible = false


func onExitBPressed():
	get_tree().quit()
