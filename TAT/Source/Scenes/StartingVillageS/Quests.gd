extends CanvasLayer




func onFirstQuestAcceptBPressed():
	get_node("FirstQuest").visible = false
	get_node("../../Player").is_movement_locked = false
