extends Path2D
#this is the maving platform script
class_name Moving_Plat
@export var path_follow_2D : PathFollow2D

#when ready call the move function move_tween()
func _ready():
	move_tween()

#move the platform between 2 location in a loop	back and forth
func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow_2D,"progress_ratio",1.0,1.5)
	tween.tween_property(path_follow_2D,"progress_ratio",0.0,1.5)
