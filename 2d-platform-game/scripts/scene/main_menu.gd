extends Control

func _on_start_game_pressed() -> void:
	GlobalPlayerManager.character_choosing=preload("res://scenes/player/mario.tscn")
	get_tree().change_scene_to_file("res://scenes/level/world1.tscn")
	
func _on_start_game_luigi_pressed() -> void:
	GlobalPlayerManager.character_choosing=preload("res://scenes/player/luigi.tscn")
	get_tree().change_scene_to_file("res://scenes/level/world1.tscn")
	
func _on_highscore_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screen/highscore_scene.tscn")
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()
