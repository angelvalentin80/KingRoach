extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_DifficultyButton_pressed():
	get_tree().change_scene("res://UI/DifficultyChange.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()



