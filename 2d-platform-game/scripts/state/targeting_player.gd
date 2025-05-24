extends State
class_name targeting_player
@export var enemy: CharacterBody2D
@export var move_speed := 60
var player: CharacterBody2D
# this is the state that the enemy is chasing the player

# this function represent when the enemy first spawns into the scence and so 
# grab the player node from the player group for later usage
func enter():
	player = get_tree().get_first_node_in_group("player")

# this function implement the chasing movement
# it first find the player distance from the enemy
# then if they are within the designated range then the enemy will move toward
# the player with a higher speed then when the enemy is moving idly
# If the player is out of range, then it will stop the current chase movement
# and emit a signal to the state_machine node to change to the idle state
func physics_update(delta: float):
	var direct = player.global_position - enemy.global_position
	if direct.length() > 25 and direct.length() < 186:
		enemy.velocity = Vector2(direct.x,0).normalized() * move_speed
	else:
		enemy.velocity=Vector2()
		
	if direct.length() >= 186:
		changed.emit(self,"idle")
