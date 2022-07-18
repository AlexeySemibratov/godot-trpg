extends Label

func _on_TowerGunCommon_on_reloading_time_changed(value, max_value):
	text = str(stepify(value, 0.1)) + "/" + str(max_value)

func _on_TowerGunCommon_on_reloading_finished():
	text = "Ready"
