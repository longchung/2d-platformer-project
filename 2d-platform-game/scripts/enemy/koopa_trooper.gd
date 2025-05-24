extends CharacterBody2D

func _physics_process(delta: float) -> void:
	var grav = 1000.0
	if not is_on_floor():
		velocity.y += grav * delta 
	move_and_slide()
	
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
# this is for when the player collide with it, it will reduce the score by 10 
# and telepoort the player back
func damage_player(body: Node2D) -> void:
	if body.is_in_group('player'):
		if AllWorld.total_score > 0:
			AllWorld.total_score -= 10
		else:
			AllWorld.total_score = 0
		body.global_position=$"../../../back_to_start".global_position

# this is for when the player hit one the head, add 20 point to the player
# then clear it
func _on_kill_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		AllWorld.total_score+=20
		self.queue_free()
		
