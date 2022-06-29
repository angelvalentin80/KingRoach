extends CanvasLayer



func _ready():
	updateScore()

func updateScore():
	var score = $"/root/Global".score
	$Score.text = "Score: " + str(score)


func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
	print("hello")


func _on_Menu_pressed():
	get_tree().change_scene("res://UI/StartScene.tscn")
