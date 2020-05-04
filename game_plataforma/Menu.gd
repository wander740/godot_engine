extends Control



func _on_start_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_quit_pressed():
	get_tree().quit()
