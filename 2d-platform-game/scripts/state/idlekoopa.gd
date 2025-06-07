extends State
class_name idlekoopa
@export var enemy: CharacterBody2D
@export var move_speed := 10
var move_direct : Vector2
var idle_time: float
var player: CharacterBody2D
#this is the idle state

# This function control how the enemy moves idly
func idle_move():
	move_direct= Vector2 (randf_range(-0.5,0.5),0).normalized()
	idle_time = 1
#this function represent when the enemy first spawns into the scence and so 
#grab the player node from the player group for later usage
func enter():
	player = get_tree().get_first_node_in_group("player")
	idle_move()
# this function either update our idle time for the current idle movement or
# start a new idle movement cicle
func update(delta: float):
	if idle_time > 0: 
		idle_time -= delta
	else:
		idle_move()
# This function implement the actual idle movement of the enemy also if the 
# player is within a distance range,it will emit a signal back to the
# state_machine node to update to the targeting_player state
func physics_update(delta: float):
	if enemy:
		enemy.velocity=move_direct*move_speed
		
	var direct = player.global_position - enemy.global_position
	
	if direct.length() > 25 and direct.length() < 186:
		changed.emit(self,"targeting_playerkoopa")	
		
	
# if hit go to the the shell state 
func _on_kill_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		changed.emit(self,"shell")
