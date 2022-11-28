class_name MainUI
extends Control

signal level_completed_dialog_ok_pressed

var alert_dialog = preload("res://scenes/ui/dialog/AlertDialog.tscn")


func show_level_completed_dialog(level_data: LevelData):
	var dialog: AlertDialog = alert_dialog.instantiate()
	
	var button_text: String
	if (level_data.next_level != Levels.LevelType.NONE):
		button_text = "Next level"
	else:
		button_text = "Back to main menu"
		
	dialog.setup(
		"Level completed",
		"You earn some money!",
		button_text
	)
	
	dialog.button_pressed.connect(self._on_level_complete_dialog_ok_pressed)
	add_child(dialog)
	

func show_level_failed_dialog(level_data: LevelData):
	var dialog = alert_dialog.instantiate()
	dialog.setup(
		"You lose",
		"Youre base was destroyed",
		"Back to main menu"
	)
	
	dialog.button_pressed.connect(self._open_main_menu)
	add_child(dialog)
	
	
func _on_level_complete_dialog_ok_pressed():
	level_completed_dialog_ok_pressed.emit()
	
	
func _open_main_menu():
	SceneNavigator.open_main_menu()
	
	

