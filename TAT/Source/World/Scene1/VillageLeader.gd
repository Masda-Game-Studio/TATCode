extends Sprite2D

var is_body_inside = false



func onBodyEntered(body):
	if(body == get_node("/root/TAT/player")):
		is_body_inside = true


func onBodyExited(body):
	if(body == get_node("/root/TAT/player")):
		is_body_inside = false
