extends KinematicBody2D


export (int) var speed = 6000
var movement
var collision
var controlled_by_user = Global.controlling_special_charac
var is_attacking = false
var direction = 0
var pos = 600
var quest_finished = Global.side_quest_finished
signal attack()
	
func _ready():
	if quest_finished:
		queue_free()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false 
	
func move(to_pos, dir):
	direction = dir
	pos = to_pos
	
func _physics_process(delta):
	controlled_by_user = Global.controlling_special_charac
	movement = Vector2()
	if controlled_by_user:
		#if Input.is_action_pressed("ui_right"):
		#	movement.x += 1
		#if Input.is_action_pressed("ui_left"):
		#	movement.x -= 1
		if Input.is_action_pressed("attack"):
			if !is_attacking && $AnimatedSprite.animation != "walking":
				$AnimatedSprite.animation = "attack"
				$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
				is_attacking = true
		if movement.length() > 0:
			movement = movement.normalized() * speed
			$AnimatedSprite.play()
		else:
			if !is_attacking:
				$AnimatedSprite.animation = "idle"
				# Set direction according to the last one

				$AnimatedSprite.flip_h = $AnimatedSprite.flip_h
		if movement.x != 0:
			##Movemente animation
			$AnimatedSprite.animation = "walking"
			is_attacking = false
			## Switch side npc is seeing
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = movement.x < 0
			
		move_and_slide(movement * delta)
	else:
		# if the npc doesnt have the instruction to move forward is in idle mode
		if direction == 0:
			$AnimatedSprite.animation = "idle"
			
		# stop at the indicated pos
		if position.x > pos:
			direction = 0
			$AnimatedSprite.animation = "idle"
			
		movement.x += direction
			
		if movement.length() > 0:
			movement = movement.normalized() * speed
		
		move_and_slide(movement * delta)

		if movement.x != 0:
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.flip_h = direction < 0

func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)

func set_animation(animation):
	$AnimatedSprite.animation = animation



func _on_AnimatedSprite_animation_finished():
	if is_attacking:
		emit_signal("attack")
		Global.controlling_special_charac = false
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		is_attacking = false


func _on_flexible_dialogues_kinght_finished_dialogue():
	Global.controlling_special_charac = true


func _on_player_finished_side_quest():
	move(1900,1)


func _on_event_trigger3_child_has_gone():
	hide()
	Global.side_quest_finished = true
	queue_free()



func _on_flexible_dialogues_side_miss_finished_dialogue():
	move(1170,1)


func _on_event_trigger3_side_mission_level_s():
	hide()
	var player = get_tree().get_root().find_node("player",true,false)
	if player:
		player.set_active(true)
	queue_free()
