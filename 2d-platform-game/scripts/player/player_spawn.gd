extends Node2D

func _ready() -> void:
	GlobalPlayerManager.add_player_instance()
	if GlobalPlayerManager.player.get_parent():
		GlobalPlayerManager.player.get_parent().remove_child(GlobalPlayerManager.player)	
	self.add_child(GlobalPlayerManager.player)
	GlobalPlayerManager.set_player_position(global_position)
