extends Control
#this is the pause menu interface
class_name pause_menu
const facade= preload("res://scripts/scene/menu_facade.gd") 
@export var current: Node2D

#initilize the menu facade	
var menu = facade.new()
var is_paused:bool = false

#on ready call ready_now function pf facde to set volume slider to match the associated bus
func _ready() -> void:
	menu.ready_now(current)
	
# when user press the pause button, in this case esc, call the pause function of facade
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		is_paused = menu.pause_pressed(current,is_paused)
		
#when user press resume button, call the resume function of facade	
func _on_resume_pressed() -> void:
	menu.resume_press(current,is_paused)

#when user press resume button, call the quit function of facade	
func _on_quit_pressed() -> void:
	menu.quit_press(current)

#when the player change the slider of master sound, call the sound change function of facade	
func _on_master_volume_value_changed(value: float) -> void:
	menu.master_changed(AudioServer.get_bus_index("Master"),value)

#when the player change the slider of bgm sound, call the sound change function of facade
func _on_bgm_volume_value_changed(value: float) -> void:
	menu.master_changed(AudioServer.get_bus_index("bgm"),value)

#when the player change the slider of effect sound, call the sound change function of facade
func _on_effect_volume_value_changed(value: float) -> void:
	menu.master_changed(AudioServer.get_bus_index("effect"),value)

#when the player change the slider of player sound, call the sound change function of facade
func _on_player_volume_value_changed(value: float) -> void:
	menu.master_changed(AudioServer.get_bus_index("player"),value)

#when the player change the slider of enemy sound, call the sound change function of facade
func _on_enemy_volume_value_changed(value: float) -> void:
	menu.master_changed(AudioServer.get_bus_index("enemy"),value)
