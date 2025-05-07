extends Node

var character_choosing=preload("res://scenes/player/mario.tscn")
#var player_spawned = false
var player : MyPlayer

func add_player_instance() -> void:
	player = character_choosing.instantiate()
	pass
	
func set_player_position(_new_position: Vector2) -> void:
		player.global_position = _new_position
		pass
	
