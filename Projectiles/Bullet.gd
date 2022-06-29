extends Area2D

export var speed = 7
var movement = Vector2()
onready var mouse_pos = null
var damageDealt = 1  # maybe

var rng = RandomNumberGenerator.new()

func _ready():
	mouse_pos = get_local_mouse_position()

func _physics_process(delta):
	movement = movement.move_toward(mouse_pos, delta)
	movement = movement.normalized() * speed
	position = position + movement
	if position.x > 320 or position.x < 0 or position.y > 180 or position.y < 0:
		queue_free()
	

	
func deleteBullet():
	rng.randomize()
	var collateChance = rng.randi_range(3,10)
	if collateChance > 3:
		self.queue_free()


func _on_Bullet_area_entered(area):
	deleteBullet()
