extends Control
#this is the main menu script

#when press mario, preload the mario player character to the 
#global_player_manager and move to world 1
func _on_start_game_pressed() -> void:
	GlobalPlayerManager.character_choosing=preload("res://scenes/player/mario.tscn")
	get_tree().change_scene_to_file("res://scenes/level/world1.tscn")

#when press luigi, preload the luigi player character to the 
#global_player_manager and move to world 1	
func _on_start_game_luigi_pressed() -> void:
	GlobalPlayerManager.character_choosing=preload("res://scenes/player/luigi.tscn")
	get_tree().change_scene_to_file("res://scenes/level/world1.tscn")

#when press change to the highscore screen	
func _on_highscore_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screen/highscore_scene.tscn")

#when press exist the game
func _on_quit_game_pressed() -> void:
	get_tree().quit()
