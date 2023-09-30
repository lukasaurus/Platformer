extends Node


var score = 0
var lives = 3

signal update_score
signal update_lives

func increase_score():
	score+=1
	print("updating score")
	print(score)
	emit_signal("update_score")
	
func decrease_lives():
	lives-=1
	emit_signal("update_lives")

