extends Area2D


export var speed = 50   # og 100
export var health = 3
export var numFrom = 1  # adjust
export var numTo = 1  # adjust
export var luckyNumber = 1   # adjust
var velocity = Vector2.ZERO
var a = 0

# parent is YSort, so we are getting the player node above the YSort "directory"
onready var player = get_parent().get_node("../Player/Player")  # short cut version
#onready var player = get_parent().get_parent().get_node("Player")   # noobie version but proof of concept
onready var enemyBlood = preload("res://Characters/Enemies/EnemyBlood.tscn")
onready var regenHeart = get_parent().get_node("../regenHeart")


func _ready():
	$HealthBar.value = 100

func _physics_process(delta):
	var velocity = Vector2.ZERO
	velocity = chasePlayer(player.global_position.x, player.global_position.y, position.x, position.y)  # not working
	position += velocity.normalized() * speed * delta
	
	# new
	var playerPos = player.get_position_in_parent()
	a = stepify(velocity.angle(), PI/4) / (PI/4) # calculation to stepify angle
	a = wrapi(int(a), 0, 8)  # calculation to stepify angle
	
	if a == 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("right")    #right
	if a == 1:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("down_right")  #Down right
	if a == 2:
		$AnimatedSprite.play("down")	  #down
	if a == 3:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("down_right")	  #down left
	if a == 4:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("right")  #left
	if a == 5:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("up_right")  #up left
	if a == 6:
		$AnimatedSprite.play("up")	  #up
	if a == 7:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("up_right")  #up right

# function to chase a player and find that vector and insert it in.
func chasePlayer(px, py, ex, ey):
	var velocity = Vector2(0,0)
	var vectorX = px - ex
	var vectorY = py - ey
	velocity = Vector2(vectorX, vectorY)
	return velocity
	
func take_damage():
	if !Input.is_action_pressed("boost"):
		var blood = enemyBlood.instance()
		blood.position = Vector2(position.x, position.y) 
		get_parent().add_child(blood)
		blood.emitting = true
		blood.one_shot = true
		health -= 1
		$HealthBar.value -= 33.4
	if health <= 0:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var my_random_number = rng.randi_range(numFrom, numTo)  # adjust
		if my_random_number == luckyNumber:
			if player.hp != 5:
				regenHeart.visible = true
				regenHeart.position.x = position.x
				regenHeart.position.y = position.y
		self.queue_free()
		$"/root/Global".score += 10   # test test test
	
		

func _on_Enemy_area_entered(area):
	if(area.is_in_group("bullet") or (area.is_in_group("player"))):
		take_damage()
	
