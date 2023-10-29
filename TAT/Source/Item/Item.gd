extends Sprite2D

var is_inside = false
@export var item_name = ""
func onCharacterEntered(_body_rid, _body, _body_shape_index, _local_shape_index):
	is_inside = true

func onCharacterExited(_body_rid, _body, _body_shape_index, _local_shape_index):
	is_inside = false

func handleItem():
	if(is_inside):
		get_node("PickB").visible = true
		if(Input.is_action_pressed("PrimaryInteract")):
			
			if(get_node("/root/TAT/UI/Inventory/Bag").addItem(item_name)):
				queue_free()
			
	else:
		get_node("PickB").visible = false

func _physics_process(_delta):
	handleItem()
