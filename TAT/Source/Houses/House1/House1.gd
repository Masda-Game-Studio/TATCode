extends StaticBody2D
var is_inside :bool = false
var fix_bug = 0
func onCharacterEnter(_body_rid, _body, _body_shape_index, _local_shape_index):
	if(fix_bug<2):
		fix_bug += 1
	else:
		is_inside = true

func onCharacterExit(_body_rid, _body, _body_shape_index, _local_shape_index):
	is_inside = false


func InteractHouse():
	if(is_inside):
		get_node("InteractB").visible = true
		if(Input.is_action_pressed("PrimaryInteract")):
			get_node("QuestLabel").visible = true
			get_node("Timer").start()
	else:
		get_node("InteractB").visible = false

func _input(_event):
	InteractHouse()


func onLabelTimerTimeout():
	get_node("QuestLabel").visible = false
