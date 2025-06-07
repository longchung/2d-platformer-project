extends Area2D
#this is the coin script
@onready var animate = $animation
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

#when player collide with the coin, add 1 to coin number and 10 to score
# then play the float up and dissapear animation and free it from the queue
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		AllWorld.coin+=1
		AllWorld.total_score +=10
		var tween = create_tween()	
		tween.tween_property(self,"position",position + Vector2(0.0,-30.0),0.5)
		tween.tween_property(self,"modulate:a",0.0,0.5)
		audio_stream_player.play()
		tween.tween_callback(self.queue_free)
		
