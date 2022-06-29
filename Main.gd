extends Node

var enemyObj = preload("res://Characters/Enemies/Enemy.tscn")
var randomTimer = RandomNumberGenerator.new()



func _ready():
	randomize()
	$"/root/Global".score = 0
	$Player/Player.position = $PlayerPos.position 
	
func subtractBoost():
	if Input.is_action_pressed("boost"):
		$BoostBar.value -= 1

func fillBoost():
	if !Input.is_action_pressed("boost"):
		$BoostBar.value += float(0.1)
	
func edit_hearts():
	if $Player/Player.hp == 4:
		$Hearts/Heart1.visible = false	
	if $Player/Player.hp == 3:
		$Hearts/Heart2.visible = false	
	if $Player/Player.hp == 2:
		$Hearts/Heart3.visible = false	
	if $Player/Player.hp == 1:
		$Hearts/Heart4.visible = false	
	if $Player/Player.hp == 0:
		$Hearts/Heart5.visible = false
		


	
func updateScore():
	var score = $"/root/Global".score
	$Score.text = "Score: " + str(score)
	
	
func _physics_process(delta):
	edit_hearts()
	updateScore()
	fillBoost()  # fill automatically
	subtractBoost() # subtract boost when pressing shift

func _on_Enemy_spawn_timer_timeout():
	var enemy_position = Vector2(rand_range(-160, 400), rand_range(-90, 260)) # adjust numbers
	
	#make sure enemy is not in viewport
	while enemy_position.x < 370 and enemy_position.x > -80 or enemy_position.y < 230 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160, 400), rand_range(-90, 260))
		
	var enemy = enemyObj.instance()
	enemy.position = enemy_position
	$YSort.add_child(enemy)
		







