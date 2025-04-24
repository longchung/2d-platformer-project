extends Node

var coin = 0
var total_score = 0

func _process(delta: float) -> void:
	$"GUI/total_score".text = str(total_score)
	$"GUI/coin".text = str(coin)
