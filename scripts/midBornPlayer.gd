extends KinematicBody2D


export (int) var speed = 6000 
var screen_size
var movement
var points = 0
var collision
# check wich character are you playing
var character = Global.character
# side quest variables
var times_talked_to_main_npc = 0
signal last_talk()
signal finished_side_quest()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false 
	
func _physics_process(delta):
	movement = Vector2()
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if movement.length() > 0:
		movement = movement.normalized() * speed
		$AnimatedSprite.play()
	else:
		if character == "woman":
			$AnimatedSprite.animation = "idle_woman"
		elif character == "elder":
			$AnimatedSprite.animation = "idle_elder"
	
	if movement.x != 0:
		if character == "woman":
			$AnimatedSprite.animation = "walking_woman"
		elif character == "elder":
			$AnimatedSprite.animation = "walking_elder"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = movement.x < 0
		
	move_and_slide(movement * delta)
	
	#if (get_slide_count() > 0):
	#	for i in range(get_slide_count()):
	#		var enemyName = get_slide_collision(i).collider.name
	#		if(enemies.has(enemyName)):
	#			touched(enemyName)
				

func set_active(active):
	print("movement of player:", active)
	set_physics_process(active)
	set_process(active)
	set_process_input(active)

func set_animation(animation):
	$AnimatedSprite.animation = animation

func _on_dialogue_finished_z3_quest():
	$thought_hint.play("I should go with the merchant to complete the task")
	$quest_finished.start()

func _on_zone2_started_final_quest():
	$quest_delivered.start()
	$thought_hint.play("I should go to the gate... something is happening")



func _on_Main_finished_final_quest():
	$final_quest_finished.start()
	$thought_hint.play("This is enough people, I should go back with lady Liana")

#Main quest
func _on_quest_finished_timeout():
	$thought_hint.hide()


func _on_quest_delivered_timeout():
	$thought_hint.hide()

#Final quest
func _on_final_quest_finished_timeout():
	$thought_hint.hide()

# Side quest
func _on_dialogue_finished_dialogue():
	set_active(false)


func _on_flexible_dialogues_finished_dialogue():
	times_talked_to_main_npc += 1
	if times_talked_to_main_npc < 3:
		set_active(false)
	if times_talked_to_main_npc == 2:
		emit_signal("last_talk")
	if times_talked_to_main_npc == 3:
		emit_signal("finished_side_quest")


func _on_flexible_dialogues_kinght_finished_dialogue():
	set_active(false)


func _on_flexible_dialogues_side_miss_finished_dialogue():
	set_active(false)
