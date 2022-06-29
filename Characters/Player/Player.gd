extends KinematicBody2D

export var speed = 300
export var hp = 5
var velocity = Vector2.ZERO
var a = 0

# instance bullet
var BulletObj = preload("res://Projectiles//Bullet.tscn")

# grab boost bar values
onready var boostBar = get_parent().get_node("BoostBar")
onready var hearts = get_parent().get_parent().get_node("Hearts")
onready var heartObject = get_parent().get_parent().get_node("regenHeart")

# custom signal
func _ready():
	pass	

func get_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1	
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if Input.is_action_just_pressed("shoot"):
		shoot() 
	if Input.is_action_pressed("boost"):
		boost()
		if boostBar.value <= 0:
			$AnimatedSprite.modulate.a = 1
	if Input.is_action_just_released("boost"):
		speed = 300  # back to normal
		if boostBar.value > 0:
			$AnimatedSprite.modulate.a = 1
	
	velocity = velocity.normalized() * speed
	
func take_damage():
	hp -= 1
	if hp <= 0:
		queue_free()
		get_tree().change_scene("res://UI/GameOver.tscn")
	
# if player is NOT PRESSING BOOST	 take damage   ADD BOOST NOT AT 0
func _on_Area2D_area_entered(area):
	if(area.is_in_group("enemy")):	
		if !Input.is_action_pressed("boost") or boostBar.value == 0:
			take_damage()
	if(area.is_in_group("heartRegen")):
		if hp == 4:
			hp = 5
			var heart = hearts.get_node("Heart1")
			heart.visible = true
			heartObject.visible = false
		elif hp == 3:
			hp = 4
			var heart = hearts.get_node("Heart2")
			heart.visible = true
			heartObject.visible = false
		elif hp == 2:
			hp = 3
			var heart = hearts.get_node("Heart3")
			heart.visible = true
			heartObject.visible = false
		elif hp == 1:
			hp = 2
			var heart = hearts.get_node("Heart4")
			heart.visible = true
			heartObject.visible = false
		else:
			hp = 5
		

func boost():
	if boostBar.value > 0:
		speed = 500
		$AnimatedSprite.modulate.a = 0.2
		print("boosting")
	

func shoot():
	var bullet = BulletObj.instance()

	
	var mouse = get_local_mouse_position()  
	a = stepify(mouse.angle(), PI/4) / (PI/4)
	a = wrapi(int(a), 0, 8)
	
	if a == 0:
		bullet.position = $upMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  
	if a == 1:
		bullet.position = $upRightMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  
		get_parent().add_child(bullet)  
	if a == 2:
		bullet.position = $rightMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  
	if a == 3:
		bullet.position = $downRightMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  
	if a == 4:
		bullet.position = $downMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  
	if a == 5:
		bullet.position = $downLeftMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  
	if a == 6:		
		bullet.position = $leftMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  
	if a == 7:
		bullet.position = $upLeftMuzzle.global_position
		#bullet.rotation_degrees = rotation_degrees  ## THIS MIGHT HELP IN FUTURE FOR ANIMATION		
		get_parent().add_child(bullet)  


func playerAnimations():
	var mouse = get_local_mouse_position()  
	a = stepify(mouse.angle(), PI/4) / (PI/4)
	a = wrapi(int(a), 0, 8)
	
	if a == 0:
		$AnimatedSprite.play("up")  
	if a == 1:
		$AnimatedSprite.play("up_right")
	if a == 2:
		$AnimatedSprite.play("right")	
	if a == 3:
		$AnimatedSprite.play("down_right")	
	if a == 4:
		$AnimatedSprite.play("down")	
	if a == 5:
		$AnimatedSprite.play("down_left")	
	if a == 6:
		$AnimatedSprite.play("left")	
	if a == 7:
		$AnimatedSprite.play("up_left")


func _physics_process(delta):
	get_input()
	#look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity)
	playerAnimations()
	

		

	


