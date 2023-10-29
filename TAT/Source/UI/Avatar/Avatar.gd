extends Control



func _process(_delta):
	get_node("HealthBar/health_l").text = str(get_node("/root/TAT/Player").info["stats"]["health"])
	get_node("StaminaBar/stamina_l").text = str(get_node("/root/TAT/Player").info["stats"]["stamina"])
	get_node("HealthBar/max_health_l").text = str(get_node("/root/TAT/Player").info["stats"]["max_health"])
	get_node("StaminaBar/max_stamina_l").text = str(get_node("/root/TAT/Player").info["stats"]["max_stamina"])
