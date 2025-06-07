extends Node
var current_state: State
var states : Dictionary ={}
var player: CharacterBody2D
@export var init_state: State
#this is the state machine that manages all the different states

# On ready, the state machine will check all states that are attached to it as a 
# child and if it is a state then add it to the state dictionary 
# then initialize the initial state that we inject in.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.changed.connect(on_child_changed)
	if init_state:
		init_state.enter()
		current_state = init_state

# this function is used to manage any update to the current state itself	
func _process(delta: float) -> void:
	if current_state:
		current_state.update((delta))
		
# this function is used to manage any update to the enemy behaviour and movement
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

#this function implement how we change from one state to another
func on_child_changed(old_state,next_state_name):
	if old_state != current_state:
		return
	var new_state = states.get(next_state_name.to_lower())
	
	if !new_state:
		return
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
