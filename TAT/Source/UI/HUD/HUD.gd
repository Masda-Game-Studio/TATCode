extends CanvasLayer


func onBagBPressed():
	if(get_node("inventory/bag").visible == true):
		get_node("inventory/bag").visible = false
	else:
		get_node("inventory/bag").visible = true


func onCharacterPageBPressed():
	if(get_node("inventory/character_page").visible == true):
		get_node("inventory/character_page").visible = false
	else:
		get_node("inventory/character_page").visible = true

func onMenuBPressed():
	if(get_node("menu").visible == true):
		get_node("menu").visible = false
	else:
		get_node("menu").visible = true
