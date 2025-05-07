extends Node

var coin = 0
var total_score = 0
var level = 0
var max_level=0
var timer_max = 0
var level_dictionary={}



func _ready() -> void:
	var dir = DirAccess.open("res://scenes/level/")
	var temp_level = dir.get_files()
	max_level = len(temp_level)
	for i in max_level:
		var world_location = "res://scenes/level/world"+str(i+1)+".tscn"
		level_dictionary[str(i)] =  world_location
	print(level_dictionary)

func _process(_delta: float) -> void:
	$"GUI/total_score".text = str(total_score)
	$"GUI/coin".text = str(coin)
	$"GUI/time".text = str(timer_max)
	
