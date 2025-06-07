extends State
class_name shell
@export var enemy: CharacterBody2D
var timehit = 0
# this is the state that the koopa turn into its shell 

# when enter create a timer of 3 sec and start it 
func enter():
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.autostart =false
	timer.one_shot =true
	timer.wait_time = 2.5
	timer.timeout.connect(timer_timeout)
	timer.start()

#when timer run out and still haven't been hit, return to idle state	
func timer_timeout():
	enemy.get_node("./Sprite2D").texture = load("res://assets/mob/koopa.png")
	enemy.get_node("./Sprite2D").scale=Vector2(0.027,0.026)
	timehit=1
	changed.emit(self,"idlekoopa")

#make the enemy stop in place and change its sprite to shell	
func physics_update(delta: float):
	if enemy:
		enemy.velocity = Vector2(0,0)
		enemy.get_node("./Sprite2D").texture = load("res://assets/mob/koopa_shell.png")
		enemy.get_node("./Sprite2D").scale=Vector2(0.08,0.08)
		
# this function kill the koopa
func _on_kill_body_entered(body: Node2D) -> void:
	if timehit >1:
		if body.is_in_group("player"):
			AllWorld.play_sound=1
			AllWorld.total_score+=20
			enemy.queue_free()
	else:
		timehit +=1
