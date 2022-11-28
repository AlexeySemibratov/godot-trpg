extends Control

const GAME_SCENE = preload("res://scenes/MainScene.tscn")

var alert_dialog = preload("res://scenes/ui/dialog/AlertDialog.tscn")

func _on_play_button_pressed():
	SceneNavigator.open_game_scene(Levels.LevelType.LEVEL_1)


func _on_base_button_pressed():
	_show_not_implemented_dialog()


func _on_settings_button_pressed():
	_show_not_implemented_dialog()
	
	
func _show_not_implemented_dialog():
	var dialog = alert_dialog.instantiate()
	dialog.setup(
		"Warning!",
		"This feature not implemented yet",
		"OK"
	)
	add_child(dialog)
