extends Area2D

@onready var animate = $animation

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		AllWorld.coin+=1
		AllWorld.total_score +=10
		var tween = create_tween()	
		tween.tween_property(self,"position",position + Vector2(0.0,-30.0),0.5)
		tween.tween_property(self,"modulate:a",0.0,0.5)
		tween.tween_callback(self.queue_free)
		
