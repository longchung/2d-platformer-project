extends Node
#this script will also be loaded globally but after all_worl.gd
#this act as a helper for the player spawner in each level to spawn
#the select character into a level
var character_choosing=preload("res://scenes/player/mario.tscn")
var player : MyPlayer

#this function instantiate the player chracter
func add_player_instance() -> void:
	player = character_choosing.instantiate()
	pass
	
#this function set the player location to the player spawner location which
#act as our marker
func set_player_position(_new_position: Vector2) -> void:
		player.global_position = _new_position
		pass
	
