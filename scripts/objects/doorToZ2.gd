extends Area2D

var entered = false
var quest_finished = Global.side_quest_finished

func _on_door_area_body_entered(body: PhysicsBody2D):
	if quest_finished:
		$key_e.show()
		entered = true
	else:
		$hint.show()


func _on_door_area_body_exited(body):
	$key_e.hide()
	$hint.hide()
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("game_action"):
			Global.from_level = get_parent().name
			get_tree().change_scene("res://scenes/zone2.tscn")
