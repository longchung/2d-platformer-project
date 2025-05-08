extends Control
#this file is the highscore screen at the end of finishing the game
const Saved_file="res://Saved_highscore.txt"
var score=[]

#on ready, load in all the score in the Saved_highscore.txt   
func _ready() -> void:
	var file = FileAccess.open(Saved_file,FileAccess.READ)
	if FileAccess.file_exists(Saved_file):
		var temp_score1=file.get_line()
		score =temp_score1.split(",")
		
# display current top 5 highscore	
func _process(delta: float) -> void:
	$MarginContainer/VBoxContainer/score.text=str(score[0])
	$MarginContainer/VBoxContainer/score2.text=str(score[1])
	$MarginContainer/VBoxContainer/score3.text=str(score[2])
	$MarginContainer/VBoxContainer/score4.text=str(score[3])
	$MarginContainer/VBoxContainer/score5.text=str(score[4])

# when player press save
func _on_save_pressed() -> void:
	for i in range(len(score)):
		# check if our score is in top 5
		if AllWorld.total_score > int(score[i]):
			var temp = score[i]
			score[i] =str(AllWorld.total_score)
			#if our score is not the 5th one, then put it in postion and move\
			#other score down
			if i < len(score)-1: 
				for j in range(i+1,len(score)):
					var temp2=score[j]
					score[j]=temp
					temp=temp2
			var to_store = ",".join(score)
			# access the Saved_highscore.txt  and re-wrtie new top 5 score in there
			var file = FileAccess.open(Saved_file,FileAccess.WRITE_READ)
			if FileAccess.file_exists(Saved_file):
				file.store_line(to_store)
			$MarginContainer/VBoxContainer/Save.disabled=true
			break
	
# when press, reset coin, level and score then load back to the main menu
func _on_return_pressed() -> void:
	AllWorld.coin=0
	AllWorld.level=0
	AllWorld.total_score=0
	get_tree().change_scene_to_file("res://scenes/Main_Alpha.tscn")
