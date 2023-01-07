extends Area2D

var entered = false
const key_path = preload("res://scenes/objects/key_e.tscn") 

func _on_door_area_body_entered(body: PhysicsBody2D):
	$key_e.show()
	entered = true


func _on_door_area_body_exited(body):
	$key_e.hide()
	entered = false
	
func _process(delta):

	if entered == true:
		if Input.is_action_just_pressed("game_action"):
			Global.from_level = get_parent().name
			get_tree().change_scene("res://scenes/zone2.tscn")
