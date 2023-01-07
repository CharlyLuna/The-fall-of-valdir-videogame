extends KinematicBody2D


export (int) var speed = 10000
var screen_size
var movement
#var life = Resources.lifesP1
var points = 0
var collision
#var enemies = Resources.enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 100
	position.y = 150
	
func _physics_process(delta):
	movement = Vector2()

	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if movement.length() > 0:
		movement = movement.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "idle"
	
	if movement.x != 0:
		$AnimatedSprite.animation = "walking"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = movement.x < 0
		
	move_and_slide(movement * delta)
	
	#if (get_slide_count() > 0):
	#	for i in range(get_slide_count()):
	#		var enemyName = get_slide_collision(i).collider.name
	#		if(enemies.has(enemyName)):
	#			touched(enemyName)
				
