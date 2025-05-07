extends Area2D

func _on_body_entered(body: Node2D):
	if body.is_in_group('player'):
		if AllWorld.level < AllWorld.max_level-1:
			AllWorld.level +=1
			var location = AllWorld.level_dictionary[str(AllWorld.level)]
			get_tree().change_scene_to_file(location)
		else:
			get_tree().change_scene_to_file("res://scenes/screen/highscore_scene.tscn")
