extends Area2D
#this script is for spike

#when collide with a player, if score is larger than 0 then decrease it by 10
#and if it is then set it to 0
#then teleport the player by updating the player's gobal position
#to that of the marker we set in the level which is back to the start 
#of the level
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.global_position=$"..".global_position
		if AllWorld.total_score > 0:
			AllWorld.total_score -= 10
		else:
			AllWorld.total_score = 0
