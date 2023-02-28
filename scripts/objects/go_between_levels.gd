extends Area2D

var entered = false

func _on_door_area_body_entered(body: PhysicsBody2D):
	$key_e.show()
	entered = true


func _on_door_area_body_exited(body):
	$key_e.hide()
	entered = false
	
func _process(delta):
	var path_to_level = "res://scenes/{level}.tscn".format({"level": self.name})
	if entered == true:
		if Input.is_action_just_pressed("game_action"):
			Global.from_level = get_parent().name
			get_tree().change_scene(path_to_level)


func _on_Main_body_entered(body: PhysicsBody2D):
	$key_e.show()
	entered = true


func _on_Main_body_exited(body: PhysicsBody2D):
	$key_e.hide()
	entered = false
