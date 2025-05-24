extends Area2D
#this script is for spike
#when collide with a player it will teleport the player 
#by updating the player's gobal position to that of the
#marker we set in the level which is back to the start 
#of the level
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.global_position=$"..".global_position
		
