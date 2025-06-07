extends Node
# the facade menu that implment all the button of pause menu
class_name menu_facade

class on_ready:
	# when called, set each volume slider to match its current bus's vloume
	func on_ready(current: Node2D) ->void:
		current.get_node("./pause_menu/GridContainer/master_volume").value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
		current.get_node("./pause_menu/GridContainer/bgm_volume").value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("bgm")))
		current.get_node("./pause_menu/GridContainer/effect_volume").value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("effect")))
		current.get_node("./pause_menu/GridContainer/player_volume").value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("player")))
		current.get_node("./pause_menu/GridContainer/enemy_volume").value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("enemy")))
		
class pause_button:
	# if esc, pause button is press
	func _on_pause_pressed(current: Node2D,is_paused:bool) -> bool:
		is_paused= ! is_paused
		current.get_tree().paused = is_paused
		current.get_node("./pause_menu").visible = is_paused
		if is_paused == true:
			current.get_node("./ColorRect").visible =false
			current.get_node("./ColorRect2").visible =false
		else:
			current.get_node("./ColorRect").visible=true
			current.get_node("./ColorRect2").visible=true	
		return is_paused

class resume_button:
	#if rsume button is press
	func _on_resume_pressed(current: Node2D,is_paused:bool) -> void:
		is_paused = false
		current.get_tree().paused = is_paused
		current.get_node("./pause_menu").visible = is_paused
		current.get_node("./ColorRect").visible = !is_paused
		current.get_node("./ColorRect2").visible = !is_paused
			
class quit_button:
	#if quit button is press
	func _on_quit_pressed(current: Node2D) -> void:
		current.get_tree().quit() 

class master_volume:
	#if the slider of any bus is change
	func change_master(bus: int,value: float):
		AudioServer.set_bus_volume_db(bus,linear_to_db(value))

#initialize each of the method class
var resume = resume_button.new()
var quit = quit_button.new()
var master = master_volume.new()
var pause = pause_button.new()	
var start_ready = on_ready.new()

#facade function to call the resume function	
func resume_press(current: Node2D,is_paused:bool)-> void:
	resume._on_resume_pressed(current , is_paused)
	
#facade function to call the quit function	
func quit_press(current: Node2D)-> void:
	quit._on_quit_pressed(current)
	
#facade function to call the sound change function		
func master_changed(bus: int, value:float):
	master.change_master(bus,value)
	
#facade functionto call the pause function	
func pause_pressed(current: Node2D,is_paused:bool) -> bool:
	return pause._on_pause_pressed(current, is_paused)

#facade function to call the set slider volume function	
func ready_now(current:Node2D)->void:
	start_ready.on_ready(current)
