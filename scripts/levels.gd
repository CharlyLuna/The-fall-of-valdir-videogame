extends Node2D

var camera
var entered
var people_heared = Global.people_for_final_q
var final_quest_accepted =  Global.final_quest_accepted

signal world_changed(world_name) # Code deprecated
signal started_final_quest()
signal finished_final_quest()

export (String) var world_name = "zone"

func _ready():
	if Global.from_level != null:
		get_node("player").set_position(get_node(Global.from_level + "Pos").position)

	if self.name == "Main":
		camera = get_node("player/Camera2D")
		camera.limit_right = 1400
	elif self.name == "zone2":
		camera = get_node("player/Camera2D")
		camera.limit_right = 1855
	elif self.name == "zone3":
		camera = get_node("player/Camera2D")
		camera.limit_right = 1550

func _process(delta):
	if self.name == "Main":
		camera = get_node("player/Camera2D")
		camera.limit_right = 1400
	elif self.name == "zone2":
		camera = get_node("player/Camera2D")
		camera.limit_right = 1855
	elif self.name == "zone3":
		camera = get_node("player/Camera2D")
		camera.limit_right = 1550
		
	people_heared = Global.people_for_final_q
	if people_heared >= 3:
		Global.final_quest_completed = true
		emit_signal("finished_final_quest")
	
###	# CODE DEPRECATED NOT USED ANYMORE
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("world_changed", world_name)

func _on_door_area_body_entered(body: PhysicsBody2D):
	entered = true


func _on_door_area_body_exited(body: PhysicsBody2D):
	entered = false
###

func _on_dialogue_delivered_quest():
	emit_signal("started_final_quest")


func _on_dialogue_dialogue_final_quest():
	if final_quest_accepted:
		Global.people_for_final_q += 1
		print(people_heared)
