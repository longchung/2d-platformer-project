extends Node2D
#act as the marker and spawner to put any player character into a scene

#when ready, call the gloval_player_manager helper script to instantiate
#the player, remove any old parent it still have
#add the player to the scene then call the set_player_position function 
#to update play gobal position to the spawner gobal position
func _ready() -> void:
	GlobalPlayerManager.add_player_instance()	
	self.add_child(GlobalPlayerManager.player)
	GlobalPlayerManager.set_player_position(global_position)

#add_child is called here so that we don't put our chracter into the
#main menu and highscore screen
