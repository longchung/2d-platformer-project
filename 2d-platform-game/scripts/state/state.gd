extends Node2D
class_name State
signal changed
# act as the template state class with all 4 functionality in it.
# allowing us to us it in the state_machine node as a placeholder 
# so that when we inject the state we want, that state implmentation of one of
# these functions will overide the one here, while one that the other state 
# didn't implement just uses the one here which do nothing.

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
