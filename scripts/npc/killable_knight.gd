extends KinematicBody2D

export (int) var speed = 4000
var movement = Vector2()
var direction = 0
var collision
var entered
var walking_limit = 0
#Variable to see if the trigger action has already happened
var death = false
#Check if the mission involving the npc hasn't finished
var quest_finished = Global.side_quest_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	#Only leave the hide and queue_free() method
	#hide()
	move(1170)
	if quest_finished:
		queue_free()
	
func move(limit):
	direction = 1
	walking_limit = limit

func _physics_process(delta):
	if direction != 0:
		movement = Vector2()
		collision = move_and_collide(movement * delta)
		
		# Stops at position to make its interaction
		if position.x > walking_limit:
			direction = 0
			$AnimatedSprite.animation = "idle"
			
		movement.x += direction
			
		if movement.length() > 0:
			movement = movement.normalized() * speed
		
		move_and_slide(movement * delta)

		if movement.x != 0:
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.flip_h = direction < 0



func _on_dialogue_finished_dialogue():
	show()
	move(1170)


func _on_flexible_dialogues_finished_dialogue():
	if !death:
		show()
		move(1170)


func _on_lowborn_child_attack():
	death = true
	$AnimatedSprite.animation = "death"
	$death_timer.start()
