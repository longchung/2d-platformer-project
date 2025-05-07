extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_position($"..".global_position)
		if AllWorld.total_score > 0:
			AllWorld.total_score -= 10
			if AllWorld.total_score <0:
				AllWorld.total_score = 0
