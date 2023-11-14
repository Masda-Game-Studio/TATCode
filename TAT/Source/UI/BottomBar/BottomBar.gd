extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("health_bar").value = get_node("/root/TAT/player").info["stats"]["health"]
	get_node("health_bar").max_value = get_node("/root/TAT/player").info["stats"]["max_health"]
	get_node("stamina_bar").value = get_node("/root/TAT/player").info["stats"]["stamina"]
	get_node("stamina_bar").max_value = get_node("/root/TAT/player").info["stats"]["max_stamina"]
	get_node("health_bar/health_l").text = str(get_node("/root/TAT/player").info["stats"]["health"])
	get_node("stamina_bar/stamina_l").text = str(get_node("/root/TAT/player").info["stats"]["stamina"])
	get_node("health_bar/max_health_l").text = str(get_node("/root/TAT/player").info["stats"]["max_health"])
	get_node("stamina_bar/max_stamina_l").text = str(get_node("/root/TAT/player").info["stats"]["max_stamina"])
