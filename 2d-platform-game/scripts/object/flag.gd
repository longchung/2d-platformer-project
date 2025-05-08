extends Area2D
# this script is the flag at the end of the level that load in the next level
# when collide with a player, get next scene from dictionary and load to it
# or load the highscore screen if all level has been went through
func _on_body_entered(body: Node2D):
	if body.is_in_group('player'):
		if AllWorld.level < AllWorld.max_level-1:
			AllWorld.level +=1
			var location = AllWorld.level_dictionary[str(AllWorld.level)]
			get_tree().change_scene_to_file(location)
		else:
			get_tree().change_scene_to_file("res://scenes/screen/highscore_scene.tscn")
