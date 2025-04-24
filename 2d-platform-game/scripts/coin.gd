extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		AllWorld.coin+=1
		AllWorld.total_score +=10
		queue_free()
